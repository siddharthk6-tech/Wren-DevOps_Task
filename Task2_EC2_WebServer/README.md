# Task 2 – EC2 Web Server Deployment with Monitoring

## Description
This task demonstrates automated provisioning, deployment, and monitoring of a web server using **Terraform** and **Ansible**:

- **Terraform** provisions the infrastructure (EC2 instance) in AWS.
- **User data** installs a web server and hosts a custom index page.
- **Ansible** orchestrates Terraform execution and displays outputs.
- **Monitoring** setup ensures the instance and web server health can be observed (basic metrics or logs).

This simulates a typical DevOps workflow for deploying and monitoring applications on cloud infrastructure with automated provisioning.

## Tools & Technologies Used
- Terraform
- Ansible
- Monitoring Tools – e.g., CloudWatch, basic health checks

## How to Run

1. Make sure you have **Ansible**, **Terraform**, and **AWS CLI** configured with proper credentials.
2. Run the playbook:
   command: ansible-playbook run_terraform_.yml

## Output
After deployment, the following outputs are displayed:

1. **EC2 Public IP** – Access your instance directly.
2. **HTTP link** – Open the custom index page in a browser.
3. **Index.html verification** – Confirm the file is served correctly via HTTP.
4. **Monitoring verification** – Basic health check or metrics confirming the web server is running.

## Steps Executed
1. Terraform initializes and provisions the EC2 instance using the specified key pair in the required region.
2. Web server installed automatically via **user data**.
3. Custom `index.html` deployed on the web server.
4. Ansible runs a playbook to:
   - Apply Terraform configuration
   - Show EC2 public IP
   - Verify webpage availability via HTTP
   - Verify monitoring metrics/logs
5. Monitoring setup configured (e.g., CloudWatch).


