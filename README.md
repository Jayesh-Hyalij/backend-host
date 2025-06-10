# 3-Tier Docker Project

This project implements a 3-tier architecture using Docker containers, with each tier running in its own container on separate machines managed by different engineers. The three tiers are:

- **Frontend**: Container running the user interface built with JavaScript, HTML, and CSS.
- **Backend**: Container running the backend server built with Java (Spring Boot), Maven, and OpenJDK.
- **Database**: Container running the MariaDB database.

## Project Overview

The project is designed to be developed and deployed in a distributed manner, where:

- The **Frontend Engineer** creates and manages the frontend container on their machine.
- The **Backend Engineer** creates and manages the backend container on their machine.
- The **Database Engineer** creates and manages the database container on their machine.

Each container runs independently but communicates over the network to form the complete application.

## Dependencies

- **Java Development Kit (JDK) 21** (Note: Backend Dockerfile currently uses OpenJDK 17)
- **Maven** (for building the backend Spring Boot application)
- **MariaDB** (for the database container)
- **JavaScript, HTML, CSS** (for the frontend)
- **Docker** (for containerization on all machines)

---

## Running the Project

Each engineer runs their respective container on their machine. The containers communicate over the network using appropriate IP addresses or hostnames.

- Ensure network connectivity between machines.
- Configure backend to connect to the database container.
- Configure frontend to connect to the backend container.

---

Here's a step-by-step guide to set up Tailscale for Docker Swarm across machines on different networks (e.g., home, cloud, office) to enable secure container-to-container communication.

🧰 **What You’ll Achieve**
✅ Connect 3 machines over a virtual private network
✅ Enable Docker Swarm + overlay network to span across networks
✅ Allow containers to communicate by name, securely

## Notes

- Each container is developed, built, and run independently by different engineers on separate machines.
- The project dependencies include Maven, JDK 21 (backend uses OpenJDK 17 in Dockerfile), MariaDB, JavaScript, HTML, and CSS.
- Adjust versions and configurations as needed based on your environment.

---

This README provides an overview and setup instructions for the 3-tier Docker project with distributed container management.
