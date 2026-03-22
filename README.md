# Day 12: Automated Infrastructure with Terraform & Ansible

This project demonstrates a complete **Infrastructure-as-Code (IaC)** workflow, provisioning an AWS EC2 instance using **Terraform** and configuring it as an Nginx Web Server using **Ansible**.

---

## 🚀 Project Overview

1. **Terraform** provisions the VPC Security Group (allowing Ports 22 80 and 443).
2. **Terraform** registers the SSH Public Key with AWS.
3. **Terraform** launches the EC2 Instance (Amazon Linux).
4. **Ansible** connects to the instance to install, start, and enable Nginx.

---

## 🛠️ Prerequisites

- **WSL (Ubuntu)**: Required for running Ansible on Windows.
- **Terraform**: Installed inside WSL (`sudo apt install terraform`).
- **Ansible**: Installed inside WSL (`sudo apt install ansible`).
- **AWS CLI**: Configured with credentials (`aws configure`).

---

## 📂 File Structure

```text
.
├── ansible/
│   └── nginx_setup.yml    # Ansible Playbook for Nginx configuration
├── ec2.tf                 # Main Terraform configuration
├── security_group.tf      # Security Group for ec2
├── providers.tf           # Security Group for ec2
├── variables.tf           # Infrastructure variables
├── outputs.tf             # Output for EC2 Public IP
└── nginx-server-key.pub   # SSH Public Key (generated locally)



📝 Setup Instructions1. Generate SSH Key PairInside your project directory in WSL, generate the keys that both tools will use:Bash# Generate the keys

ssh-keygen -t rsa -b 4096 -f ./nginx-server-key -N ""

# Move the private key to Linux home for correct permissions

cp nginx-server-key ~/nginx-server-key
chmod 400 ~/nginx-server-key


2. Deploy with TerraformInitialize the working directory and create the infrastructure

terraform init
terraform apply -auto-approve


3. Configure with AnsibleOnce the instance is running, capture the IP and trigger the configuration Capture the Public IP

IP=$(terraform output -raw nginx_server_ip)

# Run the Playbook
ansible-playbook -i "$IP," \
    -u ec2-user \
    --private-key ~/nginx-server-key \
    --ssh-common-args='-o StrictHostKeyChecking=no -o IdentitiesOnly=yes' \
    ../ansible/nginx_setup.yml


4. CleanupTo avoid unnecessary AWS costs, destroy the resources after testing

terraform destroy -auto-approve
```
