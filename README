# Machine-2 Backend Server Setup Documentation

This document explains the steps and purpose of setting up the backend server on Machine-2, which is an EC2 instance running Amazon Linux free tier. The backend server is containerized using Docker and the application is packaged as a Spring Boot jar using Maven.

---

## 1. EC2 Instance Setup

- **Machine-2** is an Amazon EC2 instance using Amazon Linux free tier.
- This instance will host the backend server using Docker containers.

---

## 2. Install Docker

Create a directory to host Docker setup files:

```bash
mkdir backend-host
cd backend-host
```

Create a shell script `docker.sh` with the following content to install Docker:

```bash
# Step 1: Clean any broken or old Docker repo
sudo rm -f /etc/yum.repos.d/docker*.repo

# Step 2: Refresh the package metadata
sudo dnf clean all
sudo dnf makecache
sudo dnf update -y

# Step 3: Install Docker from the Amazon Linux repo
sudo dnf install -y docker

# Step 4: Start and enable Docker service
sudo systemctl enable --now docker

# Step 5: Verify Docker is installed
docker --version
```

Run the script to install Docker:

```bash
bash docker.sh
```

**Purpose:**  
This script ensures any old Docker repositories are removed, refreshes the package metadata, installs Docker from the official Amazon Linux repository, starts the Docker service, enables it to start on boot, and verifies the installation.

---

## 3. Create Docker Volume

Create a Docker volume to persist backend data:

```bash
docker volume create backend-data
docker volume ls
```

**Purpose:**  
Docker volumes provide persistent storage independent of containers. This volume will store backend data to ensure it is not lost when containers are stopped or removed.

---

## 4. Package the Application as a .jar

If Maven is not installed, install it:

```bash
sudo yum install maven -y
```

Build the Spring Boot application package:

```bash
mvn clean package
```

Or skip tests for faster builds:

```bash
mvn clean package -DskipTests
```

**Purpose:**  
Maven is used to build the Java Spring Boot application and package it as an executable jar file, which will be run inside the Docker container.

---

## 5. Dockerfile

Use the following Dockerfile (move it to the `backend-host` directory):

```dockerfile
# Use Maven 3 with OpenJDK 17 base image
FROM maven:3.8.6-openjdk-17

# Declare /app as a volume mount point
VOLUME ["/app"]

# Set working directory
WORKDIR /app

# Build the Spring Boot application and run the jar
ENTRYPOINT ["sh", "-c", "mvn clean package -DskipTests && java -jar /app/target/*.jar"]
```

**Purpose:**  
This Dockerfile uses a Maven base image with OpenJDK 17, sets up the working directory, declares a volume for `/app`, builds the application inside the container, and runs the packaged jar.

---

## 6. Build Docker Image

Build the Docker image with a tag:

```bash
docker build -t jayeshhyalij/backend:v1 .
```

Check the image is created:

```bash
docker images
```

**Purpose:**  
This step builds the Docker image from the Dockerfile and tags it for easy reference.

---

## 7. Run a Container Using the Volume

Run the container in detached mode, mapping the volume:

```bash
docker run -d -P --name backend-server -v /var/lib/docker/volumes/backend-data:/app/data jayeshhyalij/backend:v1 sh
```

Check container logs:

```bash
docker logs backend-server
```

**Purpose:**  
This runs the backend server container with the persistent volume mounted to `/app/data` inside the container. Logs can be checked to verify the container is running correctly.

---

## 8. Push Docker Image to Repository

Tag and push the image to a Docker repository:

```bash
docker tag jayeshhyalij/backend:v1 jayeshhyalij/backend:v1
docker push jayeshhyalij/backend:v1
```

**Purpose:**  
This step tags the local image and pushes it to a remote Docker repository for sharing or deployment.

---

# Summary

This document covers the setup of the backend server on Machine-2 EC2 instance, including Docker installation, volume creation, application packaging, Docker image building, container running, and pushing the image to a repository. Each step is designed to ensure a smooth and persistent backend server deployment using Docker containers.
