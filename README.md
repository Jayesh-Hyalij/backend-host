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

🚀 **Step-by-Step Tailscale + Docker Swarm Setup** <br>

Here's a step-by-step guide to set up Tailscale for Docker Swarm across machines on different networks (e.g., home, cloud, office) to enable secure container-to-container communication. <br>

🧰 **What You’ll Achieve**

✅ Connect 3 machines over a virtual private network <br>
✅ Enable Docker Swarm + overlay network to span across networks  <br>
✅ Allow containers to communicate by name, securely  <br>

🖥️ **Machines Required**  <br>
Example:
```ssh
| Role     | Hostname    | Location | Will Run           |
| -------- | ----------- | -------- | ------------------ |
| Manager  |  manager-1  | Home     | Swarm manager      |
| Worker 1 |  worker-1   | Cloud    | Backend container  |
| Worker 2 |  worker-2   | Office   | Database container |
```


🚀 **Step-by-Step Tailscale + Docker Swarm Setup**

✅ *Step 1: Install Tailscale on All Machines*  <br>

🔧 Linux (Ubuntu/Debian)
```ssh
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
On first run, it will open a browser for login. Login with Google, GitHub, etc.  <br>

✅ *Step 2: Verify All Hosts Are Connected*
After login, you’ll see output like:  <br>
```ssh
Logged in as you@example.com.
100.101.102.1   manager-1
100.101.102.2   worker-1
100.101.102.3   worker-2
```
✅ These are Tailscale IPs (in the 100.x.x.x range). <br>

Test:  <br>
```ssh
ping 100.101.102.2   # from manager
```
If ping works, you’re securely connected ✅

✅ *Step 3: Initialize Docker Swarm on the Manager Node* <br>
Use Tailscale IP to advertise the manager:  
```ssh
docker swarm init --advertise-addr 100.101.102.1
```

Copy the join token from the output, e.g.:
```ssh
docker swarm join --token SWMTKN-1-abc123 ... 100.101.102.1:2377
```

✅ *Step 4: Join Worker Nodes to the Swarm*

On each worker node, run the token command:
```ssh
docker swarm join --token <token-from-above> 100.101.102.1:2377
```

To verify: <br>
```ssh
docker node ls     # On the manager
```
You should see all 3 nodes listed.

✅ *Step 5: Create an Overlay Network for Containers*

On the manager:
```ssh
docker network create --driver overlay --attachable my_overlay
```

✅ *Step 6: Deploy Containers Across Nodes*  <br>
Example:
```ssh
docker service create \
  --name frontend \
  --network my_overlay \
  --replicas 1 \
  --constraint 'node.hostname == manager-1' \
  nginx

docker service create \
  --name backend \
  --network my_overlay \
  --replicas 1 \
  --constraint 'node.hostname == worker-1' \
  my-backend-image

docker service create \
  --name db \
  --network my_overlay \
  --replicas 1 \
  --constraint 'node.hostname == worker-2' \
  mysql
```
➡️ All 3 services will now communicate securely using service names (frontend, backend, db).

📦 **Example: Container-to-Container Communication**  <br>

Inside the backend container:
```ssh
ping db
curl db:3306
```

Inside the frontend container:
```ssh
curl backend:5000
```
Docker Swarm + Tailscale handles the cross-host routing!

🧠 **Bonus Tips**

```ssh
| Task               | Command                                                                 |
| ------------------ | ----------------------------------------------------------------------- |
| View Tailscale IP  | `tailscale ip -4`                                                       |
| View all nodes     | `tailscale status`                                                      |
| Auto-start on boot | `sudo tailscale up --authkey <key>` *(use auth key for headless setup)* |
| Revoke devices     | [tailscale.com/admin](https://tailscale.com/admin)                      |
```

<hr>

## Notes

- Each container is developed, built, and run independently by different engineers on separate machines.
- The project dependencies include Maven, JDK 21 (backend uses OpenJDK 17 in Dockerfile), MariaDB, JavaScript, HTML, and CSS.
- Adjust versions and configurations as needed based on your environment.

---

This README provides an overview and setup instructions for the 3-tier Docker project with distributed container management.
