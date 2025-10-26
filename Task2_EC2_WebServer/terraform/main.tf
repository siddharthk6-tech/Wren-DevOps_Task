
provider "aws" {
  region = var.region
}

##########################
# Security Group
##########################
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH inbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

##########################
# EC2 Instance
##########################
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2 unzip curl

              # Start Apache
              echo "<h1>Welcome to Wren Kitchens and Bedrooms</h1>" > /var/www/html/index.html
              systemctl enable apache2
              systemctl start apache2

              # Install CloudWatch Agent
              cd /tmp
              curl -O https://s3.eu-west-1.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
              dpkg -i -E ./amazon-cloudwatch-agent.deb

              # CloudWatch Agent config JSON
              cat <<EOT > /opt/aws/amazon-cloudwatch-agent/bin/config.json
              {
                "metrics": {
                  "metrics_collected": {
                    "mem": {
                      "measurement": ["mem_used_percent"],
                      "metrics_collection_interval": 60
                    },
                    "disk": {
                      "measurement": ["used_percent"],
                      "resources": ["*"],
                      "metrics_collection_interval": 60
                    }
                  },
                  "append_dimensions": {
                    "InstanceId": "$${aws:InstanceId}"
                  }
                }
              }
              EOT

              # Start CloudWatch Agent
              /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
              EOF

  tags = {
    Name = "terraform-web-server"
  }
}

##########################
# SNS Topic for Alarms
##########################
resource "aws_sns_topic" "alerts_topic" {
  name = "ec2-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = var.email
}

##########################
# CloudWatch Alarms
##########################
# High CPU Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "EC2_High_CPU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Alarm when CPU exceeds 80%"
  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
  alarm_actions = [aws_sns_topic.alerts_topic.arn]
}

# Status Check Alarm
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "EC2_StatusCheckFailed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Alarm when instance fails status check"
  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
  alarm_actions = [aws_sns_topic.alerts_topic.arn]
}

##########################
# CloudWatch Dashboard
##########################
resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  dashboard_name = "EC2_WebServer_Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0, y = 0, width = 12, height = 6,
        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.web_server.id ],
            [ "CWAgent", "mem_used_percent", "InstanceId", aws_instance.web_server.id ],
            [ "CWAgent", "disk_used_percent", "InstanceId", aws_instance.web_server.id ]
          ]
          period = 60
          stat   = "Average"
          region = "eu-west-1"
          title  = "EC2 Web Server Metrics (CPU, Memory, Disk)"
        }
      }
    ]
  })
}

##########################
# Download index.html locally
##########################
resource "null_resource" "download_index" {
  depends_on = [aws_instance.web_server]

  provisioner "local-exec" {
    command = <<-EOT
      echo "Waiting for the web server to start"
      sleep 130

      mkdir -p downloads
      echo "Attempting to download index.html from ${aws_instance.web_server.public_ip}"

      # Wait until HTTP is ready
      for i in {1..12}; do
        curl -s http://${aws_instance.web_server.public_ip} -o downloads/index.html && break
        echo "Waiting for web server.. $i"
        sleep 10
      done

      if [ -f downloads/index.html ]; then
        echo "Downloaded index.html successfully! Saved at $(pwd)/downloads/index.html"
        cat downloads/index.html
      else
        echo "Failed to download index.html after multiple attempts."
      fi
    EOT
  }
}
