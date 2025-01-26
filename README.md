Create By **Sarthak**
Sure! Here's an updated **README.md** with the additional files you've mentioned under the **Ansible** and **Terraform** sections.

---

# LAMP Stack Deployment with Docker, Kubernetes, Terraform, and Ansible

This project automates the deployment and management of a **LAMP** (Linux, Apache, MySQL, PHP) stack using **Docker**, **Kubernetes**, **Terraform**, and **Ansible**. It also integrates **Prometheus** and **Grafana** for monitoring and implements **automated backups** for MySQL.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Technologies Used](#technologies-used)
3. [Folder Structure](#folder-structure)
4. [Setup and Installation](#setup-and-installation)
    - [Docker LAMP Stack](#docker-lamp-stack)
    - [Kubernetes LAMP Stack](#kubernetes-lamp-stack)
    - [Terraform & Ansible Setup](#terraform--ansible-setup)
5. [Monitoring with Prometheus and Grafana](#monitoring-with-prometheus-and-grafana)
6. [Backup Strategy](#backup-strategy)
    - [MySQL Backup Script](#mysql-backup-script)
    - [Cron Job for Automated Backups](#cron-job-for-automated-backups)
    - [Backup Storage](#backup-storage)
    - [Restoring Backups](#restoring-backups)
7. [Conclusion](#conclusion)

---

## Project Overview

This project automates the deployment of a **LAMP stack** using **Docker** and **Kubernetes**, provisions infrastructure with **Terraform** and **Ansible**, and integrates monitoring using **Prometheus** and **Grafana**. The setup includes **automated backups** of MySQL to ensure data safety and scalability.

---

## Technologies Used

- **Docker**: Containerizes the LAMP stack components (Nginx, MySQL, PHP).
- **Kubernetes (Minikube)**: Deploys the LAMP stack within a Kubernetes cluster.
- **Terraform**: Automates the provisioning of cloud resources (AWS EC2).
- **Ansible**: Automates the configuration of the LAMP stack on the EC2 instance.
- **Prometheus**: Collects and stores metrics for monitoring the LAMP stack.
- **Grafana**: Visualizes the metrics from Prometheus.
- **AWS CLI**: Used for cloud storage and backup management.

---

## Folder Structure

```
lamp-docker/
│
├── nginx/
│   └── Dockerfile
├── docker-compose.yml
├── index.php
│
lamp-K8S/
│
├── backend-service.yaml
├── backend-statefulset.yaml
├── configmap.yaml
├── frontend-deployment.yaml
├── frontend-service.yaml
├── grafana-deployment.yaml
├── hpa.yaml
├── mysql-pv-pvc.yaml
├── nginx-configmap.yaml
├── prometheus-deployment.yaml
├── secret.yaml
│
terraform/
├── .terraform/
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── terraform.tfstate
│   └── terraform.tfstate.backup
├── terraform.tfvars
├── outputs.tf
│
ansible/
├── hosts (or inventory.ini)
├── lamp.yml
│
backup.sh
prometheus.yml
README.md
.gitignore
```

---

## Setup and Installation

### Docker LAMP Stack

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/lamp-stack.git
   cd lamp-stack/lamp-docker
   ```

2. **Build and Run Docker Containers**:
   - Ensure Docker is installed and start the LAMP stack with Docker Compose:
   ```bash
   docker-compose up --build
   ```

3. **Access the Application**:
   - The application should now be accessible at `http://localhost`.

### Kubernetes LAMP Stack (Minikube)

1. **Install Minikube**:
   Follow the instructions to install Minikube from [Minikube Official Docs](https://minikube.sigs.k8s.io/docs/).

2. **Start Minikube Cluster**:
   ```bash
   minikube start
   ```

3. **Apply Kubernetes YAML Files**:
   In the `lamp-K8S/` directory, apply the Kubernetes YAML files for Nginx, PHP-FPM, and MySQL.
   ```bash
   kubectl apply -f lamp-K8S/frontend-deployment.yaml
   kubectl apply -f lamp-K8S/frontend-service.yaml
   kubectl apply -f lamp-K8S/backend-statefulset.yaml
   kubectl apply -f lamp-K8S/backend-service.yaml
   kubectl apply -f lamp-K8S/mysql-pv-pvc.yaml
   kubectl apply -f lamp-K8S/nginx-configmap.yaml
   kubectl apply -f lamp-K8S/prometheus-deployment.yaml
   kubectl apply -f lamp-K8S/grafana-deployment.yaml
   kubectl apply -f lamp-K8S/secret.yaml
   kubectl apply -f lamp-K8S/hpa.yaml
   kubectl apply -f lamp-K8S/configmap.yaml
   ```

4. **Expose Services**:
   Expose your services for external access:
   ```bash
   kubectl expose deployment nginx --type=NodePort --name=nginx-service
   kubectl expose deployment mysql --type=NodePort --name=mysql-service
   ```

5. **Access the Application**:
   - Find the Minikube IP:
   ```bash
   minikube ip
   ```
   - Access the Nginx web page via `http://<minikube_ip>:<node_port>`.

---

### Terraform & Ansible Setup

#### Provision EC2 Instance using Terraform

1. **Install Terraform**:
   Follow the instructions for installing Terraform from [Terraform Docs](https://www.terraform.io/).

2. **Create Terraform Files**:
   In the `terraform/` directory, edit the configuration files:
   - `main.tf`: Defines EC2 instances, security groups, and networking.
   - `.terraform.lock.hcl`: Locks the Terraform provider versions.
   - `terraform.tfstate`: Tracks the state of the infrastructure.
   - `terraform.tfstate.backup`: Backup of the Terraform state.

3. **Run the Terraform Commands**:
   Initialize Terraform:
   ```bash
   terraform init
   ```
   Plan the infrastructure:
   ```bash
   terraform plan
   ```
   Apply the configuration to provision resources:
   ```bash
   terraform apply
   ```

4. **Access the EC2 Instance**:
   Once provisioned, access the instance:
   ```bash
   ssh -i "Sarthak.pem" ubuntu@<EC2_PUBLIC_IP>
   ```

#### Configure LAMP Stack with Ansible

1. **Install Ansible**:
   Follow the instructions for installing Ansible from [Ansible Docs](https://docs.ansible.com/ansible/latest/installation_guide/index.html).

2. **Update `hosts` (or `inventory.ini`)**:
   In the `ansible/` directory, edit the `hosts` file to include your EC2 instance:
   ```ini
   [web]
   your_ec2_public_ip ansible_ssh_user=ubuntu ansible_ssh_private_key_file=path_to_private_key
   ```

3. **Run the Ansible Playbook**:
   Execute the playbook to configure the LAMP stack:
   ```bash
   ansible-playbook -i ansible/hosts ansible/lamp.yml
   ```

---

## Monitoring with Prometheus and Grafana

### Prometheus Setup

1. **Deploy Prometheus**:
   Apply the Prometheus deployment YAML:
   ```bash
   kubectl apply -f lamp-K8S/prometheus-deployment.yaml
   ```

2. **Expose Prometheus Service**:
   Expose Prometheus using a NodePort:
   ```bash
   kubectl expose deployment prometheus --type=NodePort --name=prometheus-service
   kubectl port-forward svc/prometheus-service 9090:9090
   ```

3. **Access Prometheus**:
   Access Prometheus at `http://localhost:9090`.

### Grafana Setup

1. **Deploy Grafana**:
   Apply the Grafana deployment YAML:
   ```bash
   kubectl apply -f lamp-K8S/grafana-deployment.yaml
   ```

2. **Expose Grafana Service**:
   Expose Grafana using a NodePort:
   ```bash
   kubectl expose deployment grafana --type=NodePort --name=grafana-service
   kubectl port-forward svc/grafana-service 3000:3000
   ```

3. **Access Grafana**:
   Access Grafana at `http://localhost:3000`.

4. **Add Prometheus as a Data Source**:
   - URL: `http://prometheus-service:9090`

5. **Import Dashboards**:
   Import dashboards for MySQL and Nginx.

---

## Backup Strategy

### MySQL Backup Script

Create the `backup.sh` script to back up MySQL databases.

```bash
#!/bin/bash
BACKUP_DIR="/path/to/backups"
DB_NAME="your_database_name"
DB_USER="root"
DB_PASSWORD="your_password"
TIMESTAMP=$(date +"%F_%T")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

# Perform MySQL dump
mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Optionally upload to S3
aws s3 cp $BACKUP_FILE s3://your-s3-bucket/
```

### Cron Job for Automated Backups

To automate backups, create a cron job:
```bash
crontab -e
```
Add the following line:
```bash
0 2 * * * /path/to/backup.sh
```

### Backup Storage

Ensure AWS CLI is configured for S3 storage:
```bash
aws configure
```

### Restoring Backups

To restore a backup:
```bash
mysql -u root -p your_password your_database_name < /path/to/backup.sql
```

---

## Conclusion

This project demonstrates a complete **LAMP stack** setup with Docker and Kubernetes, integrated with **Prometheus** and **Grafana** for monitoring and **automated backups** to ensure data safety. It also includes **Terraform** and **Ansible** for infrastructure provisioning and configuration management.

