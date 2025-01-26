---

# LAMP Stack Deployment with Docker, Kubernetes, Terraform, and Ansible

This project demonstrates the deployment and automation of a **LAMP** (Linux, Apache, MySQL, PHP) stack using various tools and technologies, including **Docker**, **Kubernetes**, **Terraform**, and **Ansible**. Additionally, it integrates **Prometheus** and **Grafana** for monitoring and implements automated MySQL backups for data safety.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Technologies Used](#technologies-used)
3. [Setup and Installation](#setup-and-installation)
    - [Docker LAMP Stack](#docker-lamp-stack)
    - [Kubernetes LAMP Stack](#kubernetes-lamp-stack)
    - [Terraform & Ansible Setup](#terraform--ansible-setup)
4. [Monitoring with Prometheus and Grafana](#monitoring-with-prometheus-and-grafana)
    - [Prometheus Setup](#prometheus-setup)
    - [Grafana Setup](#grafana-setup)
    - [Prometheus-Grafana Integration](#prometheus-grafana-integration)
5. [Backup Strategy](#backup-strategy)
    - [MySQL Backup Script](#mysql-backup-script)
    - [Cron Job for Automated Backups](#cron-job-for-automated-backups)
    - [Backup Storage](#backup-storage)
    - [Restoring Backups](#restoring-backups)
6. [Conclusion](#conclusion)

---

## Project Overview

This project automates the deployment of a **LAMP stack** using **Docker** and **Kubernetes**, and provisions infrastructure with **Terraform** and **Ansible**. The setup is enhanced with **Prometheus** and **Grafana** for monitoring and **automated backups** to ensure high availability, performance, and data safety.

### Core Components:
- **Docker**: Building and running a LAMP stack as Docker containers.
- **Kubernetes**: Deploying the LAMP stack within a Kubernetes cluster (Minikube).
- **Terraform & Ansible**: Provisioning AWS EC2 instances and configuring the LAMP stack.
- **Prometheus & Grafana**: Monitoring performance metrics of MySQL and Nginx.
- **MySQL Backup**: Automating database backups using cron jobs.

---

## Technologies Used
- **Docker** for containerizing services.
- **Kubernetes (Minikube)** for orchestrating the containers.
- **Terraform** for provisioning cloud resources (AWS EC2).
- **Ansible** for configuring the LAMP stack.
- **Prometheus** for monitoring the LAMP stack.
- **Grafana** for visualizing the metrics.
- **AWS CLI** for cloud storage and backup management.

---

## Setup and Installation

### Docker LAMP Stack
1. **Build and Run LAMP Stack** using Docker:
   - The Dockerfile for each component (Nginx, PHP-FPM, MySQL) is available in the `docker/` folder.
   - Build images and start containers:
     ```bash
     docker-compose up --build
     ```

### Kubernetes LAMP Stack
1. **Deploy the LAMP stack in Kubernetes** using **Minikube**:
   - Ensure **Minikube** is running on your system.
   - Deploy Nginx, PHP-FPM, and MySQL as services and StatefulSets in your Kubernetes cluster using the appropriate YAML files located in the `k8s/` folder.

2. **Ensure High Availability** for MySQL using **StatefulSets** with PersistentVolume and PersistentVolumeClaim.

3. **Set up Horizontal Pod Autoscaling** and configure **readiness** and **liveness probes** for Nginx and MySQL to ensure reliability.

4. **Scaling and Rolling Updates**: 
   - Implement horizontal pod autoscaling for the Nginx and MySQL services.
   - Use rolling updates for zero-downtime deployments.

### Terraform & Ansible Setup
1. **Provision EC2 Instance**:
   - Use **Terraform** to provision an EC2 instance (LAMP-server2).
   - Configure a **Security Group**, **VPC**, and **key pair** for SSH access.
   - The Terraform configuration is located in the `terraform/` folder.

2. **Configure LAMP Stack**:
   - Use **Ansible** to automate the installation of **Nginx**, **MySQL**, and **PHP** on the provisioned EC2 instance.

---

## Monitoring with Prometheus and Grafana

### Prometheus Setup
1. **Install Prometheus in Kubernetes**:
   - Prometheus will scrape metrics from MySQL and Nginx services every 15 seconds.
   - Create a `prometheus.yml` file to configure the scraping targets.
   - Deploy Prometheus in Kubernetes using `prometheus-deployment.yaml`.

2. **Expose Prometheus for Web Access**:
   - Expose the Prometheus service on port 9090 for easy access via:
     ```bash
     kubectl port-forward svc/prometheus 9090:9090
     ```

3. **Verify Prometheus Deployment**: Access Prometheus UI via `http://localhost:9090`.

### Grafana Setup
1. **Install Grafana in Kubernetes**:
   - Deploy Grafana using `grafana-deployment.yaml`.
   - Expose Grafana service on port 80 for access via the browser.
   - Access Grafana at `http://localhost:3000` (default username/password: `admin` / `admin`).

2. **Configure Prometheus as a Data Source** in Grafana:
   - Set the data source URL as `http://prometheus-service:9090`.
   - Import pre-built dashboards for MySQL and Nginx.

3. **Visualize Metrics**:
   - Use Grafana to visualize MySQL database performance, Nginx request rates, CPU usage, memory, etc.

### Prometheus-Grafana Integration
- Integrate Grafana with Prometheus to visualize key metrics from your LAMP stack (e.g., database performance, server health, etc.).

---

## Backup Strategy

### MySQL Backup Script
1. **Backup Script (`backup.sh`)**:
   - This script performs a dump of your MySQL database and stores it locally or uploads it to AWS S3.
   - Example script:
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
1. **Schedule Automated Backups** using cron:
   - Add a cron job to run the backup script daily at 2:00 AM:
     ```bash
     crontab -e
     ```
     Add:
     ```bash
     0 2 * * * /path/to/backup.sh
     ```

### Backup Storage
1. **Store backups on AWS S3** for durability and easy access:
   - Ensure the AWS CLI is configured for S3 access.
   - Optionally, set a retention policy to delete backups older than a certain period (e.g., 30 days).

### Restoring Backups
To restore a backup from a `.sql` file:
```bash
mysql -u root -p your_password your_database_name < /path/to/backup.sql
```
Ensure data integrity after restoring the backup.

---

## Conclusion

This project demonstrates a full LAMP stack deployment with Docker and Kubernetes. It incorporates the following:
- **Prometheus** and **Grafana** for real-time monitoring.
- **Automated backups** of MySQL to ensure data security.
- **Terraform** and **Ansible** for provisioning and configuration management.
- **High Availability** and **scalability** using Kubernetes features like StatefulSets and Horizontal Pod Autoscaling.



