# Summary Practice p117

# Docker Network Utility Script

A Bash script that simplifies common Docker tasks including cleanup, network management, container connection, listing, IP discovery, and container-level ping testing.

---

## 📦 Features

- 🧹 Delete all Docker containers, images, volumes, and unused data
- 🌐 Create Docker networks
- 🔌 Connect containers to networks
- 📋 List networks and their connected containers
- 🌐 Display IP addresses of containers in a network
- 📡 Ping an IP or hostname from inside a running container

---

## 🚀 Usage

```bash
./net.sh [option] [arguments...]
```

### Options

| Option | Description |
|--------|-------------|
| `--delete-all` | Delete all containers, images, and unused Docker resources |
| `--create-network <network_name>` | Create a Docker network (default: `vaio-net` if none given) |
| `--connect <container_name> <network_name>` | Run a container and connect it to the specified network |
| `--list` | List all Docker networks and the containers connected to them |
| `--ip <network_name>` | Show IP addresses of containers in the given network |
| `--ping <container_name> <target_ip>` | Ping a target IP or hostname from a specific container |
| `--help` | Show help and usage instructions |

---

## 📚 Examples

```bash
# Delete everything
./net.sh --delete-all

# Create a Docker network called my-net
./net.sh --create-network my-net

# Connect a container to a network
./net.sh --connect alpine my-net

# List all networks and connected containers
./net.sh --list

# Show IPs of containers in a network
./net.sh --ip my-net

# Ping 8.8.8.8 from inside a container
./net.sh --ping alpine-instance 8.8.8.8
```

> Note: By default, the script appends `-instance` to container names when running them.

---

## 🔧 Requirements

- Docker installed and running
- Bash shell
- Root privileges (via `sudo`)

---

## 🪪 License

**Free to use, modify, and distribute.

---

## ✍️ Author

Created by **Meir**  
Date: April 19, 2025  
Version: 7
