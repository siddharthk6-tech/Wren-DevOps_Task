# Task 2 – EC2 Web Server Deployment with Monitoring

## Description
This task demonstrates automated provisioning, deployment, and monitoring of a web server using **Terraform** and **Ansible**:

- **Terraform** provisions the infrastructure (EC2 instance) in AWS.
- **User data** installs a web server and hosts a custom index page.
- **Ansible** orchestrates Terraform execution and displays outputs.
- Optional- **Monitoring** setup was optional and not included in the task, basically it ensures the instance and web server health can be observed (basic metrics or logs).


## Tools & Technologies Used
- Terraform
- Ansible
- Monitoring Tools - CloudWatch

## How to Run

1. Make sure you have **Ansible**, **Terraform**, and **AWS CLI** configured with proper credentials.
2. Run the playbook:
   command: **ansible-playbook run_terraform.yml**

## Output
After deployment, the following outputs are displayed. Click the links to view the outputs

1. **Ansible+Terraform** [check here](https://github.com/siddharthk6-tech/Wren-DevOps_Task/blob/main/Task2_EC2_WebServer/Outputs/Task2_output-Playbook_ran_tf.png)
2. **EC2 Public IP** – Access your instance directly. [check output here](https://github.com/siddharthk6-tech/Wren-DevOps_Task/blob/main/Task2_EC2_WebServer/Outputs/Task2_output-Playbook_ran_tf.png)
3. **HTTP link** – Opens the custom index page in a browser. [Click here](https://github.com/siddharthk6-tech/Wren-DevOps_Task/blob/main/Task2_EC2_WebServer/Outputs/Task2_hosted-web-page.png)
4. **Index.html verification** – Confirm the file is served correctly via HTTP. [File Location output](https://github.com/siddharthk6-tech/Wren-DevOps_Task/blob/main/Task2_EC2_WebServer/Outputs/Task2_index-file.png) 
5. **Monitoring verification** – Basic health check or metrics confirming the web server is running.

## Steps Executed
1. Ansible does the Terraform initialization, tf plan and runs tf apply by which terraform provisions the EC2 instance using the specified key pair in the required region.
2. Web server installed automatically via **user data**.
3. Custom `index.html` deployed on the web server.
4. Ansible runs a playbook to:
   - Apply Terraform configuration
   - Show EC2 public IP
   - Verify webpage availability via HTTP
   - Verify monitoring metrics/logs
5. Monitoring setup configured (CloudWatch).






