# DevOps Assessment -

This repository contains solutions for three technical tasks.

---

## Task Overview

### **Task 1 – Software Lifecycle Workflow**
- Designed two SDLC workflow diagrams (simple & detailed)
- Output: `.drawio.xml` file (loadable directly on [draw.io](https://app.diagrams.net/)
- Includes build, deploy, and CI/CD stages

### **Task 2 – EC2 Web Server Deployment**
- Implemented using **Terraform** for provisioning and **Ansible** just orchestrates Terraform and shows outputs
- Terraform creates an EC2 instance, installs a web server, and hosts a custom index page.
- Output displays:
  - EC2 public IP
  - http link to open webpage
  - Downloaded index.html verification through HTTP.
- **Additional optional features**-  Implemented **Amazon CloudWatch monitoring** with detailed metrics, alarms, and a custom dashboard for enhanced observability, along with an **SNS topic** for real-time notifications.
   
### **Task 3 – Kubernetes Pod Diagnostic Script**
- Bash script that:
  - Identifies pods not in `Running` or `Completed` state.
  - Displays events for failed pods and their nodes.
  - Extracts the last 100 log lines.
- Tested on namespaces with healthy and failing pods (CrashLoopBackOff, ImagePullError).

---

## Tools & Technologies Used
- **Draw.io**
- **Ansible**
- **Terraform**
- **AWS(EC2,Cloudwatch,SNS)**
- **Kubernetes**
- **Bash scripting**

---

## How to Use
Each task includes its own README file explaining setup, usage **outputs/screenshots proof** to demonstrate functionality.



---
