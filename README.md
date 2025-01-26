Here's a detailed README file for your project:

---

# LAMP Stack Deployment and Automation

This project demonstrates the deployment and automation of a LAMP (Linux, Apache, MySQL, PHP) stack using Docker, Kubernetes, Terraform, and Ansible. It focuses on building, configuring, and scaling a LAMP stack across multiple platforms, ensuring high availability, and adding monitoring with Prometheus/Grafana.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Architecture](#architecture)
4. [Setup and Deployment](#setup-and-deployment)
    - [Docker Setup](#docker-setup)
    - [Kubernetes Setup](#kubernetes-setup)
    - [Terraform Setup](#terraform-setup)
    - [Ansible Setup](#ansible-setup)
5. [Scaling and High Availability](#scaling-and-high-availability)
6. [Monitoring](#monitoring)
7. [Backup Strategy](#backup-strategy)
8. [Troubleshooting](#troubleshooting)
9. [License](#license)

---

## Project Overview

This project automates the deployment of a LAMP stack in the following environments:
- **Docker**: Builds a LAMP stack using Docker Compose.
- **Kubernetes**: Deploys the LAMP stack on a Kubernetes cluster using Minikube.
- **Terraform**: Provisions AWS EC2 instances.
- **Ansible**: Configures the LAMP stack (Nginx, MySQL, PHP) on the EC2 instance.

The project ensures the following:
- High availability with scaling.
- Rolling updates for zero-downtime deployments.
- Automated MySQL backups using cron jobs.
- Monitoring with Prometheus and Grafana.

---

## Prerequisites

Before you begin, ensure that you have the following installed:

- **Docker**: For building the LAMP stack container.
- **Minikube**: For setting up a local Kubernetes cluster.
- **Kubectl**: For interacting with the Kubernetes cluster.
- **Terraform**: For provisioning AWS resources.
- **Ansible**: For configuring the LAMP stack on the EC2 instance.
- **Prometheus/Grafana**: For monitoring the services.
- **WSL** (Windows Subsystem for Linux): For a Linux environment on Windows.

---

## Architecture

The architecture for the LAMP stack includes:

1. **Docker**:
   - A lightweight container that runs Nginx, PHP-FPM, and connects to MySQL.
   
2. **Kubernetes**:
   - A **StatefulSet** for MySQL with persistent storage.
   - Horizontal Pod Autoscaling (HPA) for scaling.
   - ConfigMaps and Secrets for configuration and sensitive data management.
   - High availability via replica sets and rolling updates.

3. **Terraform**:
   - EC2 instance setup with security groups and VPC.
   
4. **Ansible**:
   - Installs Nginx, MySQL, and PHP, and configures the LAMP stack.

5. **Prometheus/Grafana**:
   - Monitors system metrics and services (MySQL, Nginx).

---

## Setup and Deployment

### Docker Setup

1. **Build the Docker Image**:
   - Navigate to the `docker` directory.
   - Run the following command:
     ```bash
     docker-compose up -d
     ```

2. **Verify the Stack**:
   - Check the running containers:
     ```bash
     docker ps
     ```

3. **Access the App**:
   - Open your browser and go to `http://localhost`.

### Kubernetes Setup

1. **Start Minikube**:
   - Launch Minikube:
     ```bash
     minikube start
     ```

2. **Apply the Kubernetes YAML Files**:
   - Apply the Kubernetes configurations (StatefulSet, Services, ConfigMaps, Secrets, etc.):
     ```bash
     kubectl apply -f kubernetes/
     ```

3. **Verify Pods**:
   - Check the deployed pods:
     ```bash
     kubectl get pods
     ```

4. **Access the Application**:
   - Expose the Nginx service using Minikube's tunnel:
     ```bash
     minikube tunnel
     ```

   - Access the app via the Minikube IP.

### Terraform Setup

1. **Provision EC2 Instance**:
   - Navigate to the `terraform` directory.
   - Initialize Terraform:
     ```bash
     terraform init
     ```

2. **Apply Configuration**:
   - Apply the configuration to provision the EC2 instance:
     ```bash
     terraform apply
     ```

3. **SSH into EC2 Instance**:
   - SSH into the instance using the key `Sarthak`:
     ```bash
     ssh -i /path/to/Sarthak.pem ec2-user@54.82.1.154
     ```

### Ansible Setup

1. **Configure EC2**:
   - Run Ansible to configure Nginx, PHP, and MySQL:
     ```bash
     ansible-playbook -i inventory/hosts playbook.yml
     ```

---

## Scaling and High Availability

- The Kubernetes deployment uses **StatefulSet** for MySQL, ensuring persistent data storage.
- Horizontal Pod Autoscaling (HPA) ensures that the application scales based on load.
- Rolling updates are configured to ensure zero-downtime deployment.

---

## Monitoring

- Prometheus and Grafana are deployed for monitoring:
  - **Prometheus** collects metrics from the Kubernetes cluster, MySQL, and Nginx.
  - **Grafana** visualizes the data and provides dashboards for monitoring.

---

## Backup Strategy

- **MySQL backups** are automated using cron jobs that back up the database at regular intervals. The backups are stored in an S3 bucket for persistence.

---

## Troubleshooting

1. **Docker Issues**:
   - Ensure that Docker is running and that there are no conflicting containers.
   
2. **Kubernetes Issues**:
   - Verify that Minikube is running:
     ```bash
     minikube status
     ```
   - Check pod logs:
     ```bash
     kubectl logs <pod-name>
     ```

3. **EC2 Issues**:
   - Ensure the correct security group and VPC configurations are in place.
   - SSH into the instance and check the application logs for errors.

---

## License

This project is licensed under the MIT License.

---

This README provides an overview of how to set up and deploy a LAMP stack with high availability, scaling, monitoring, and automated backups.
