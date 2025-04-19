
# Docker Management Script

This script allows you to perform various Docker operations such as stopping containers, deleting images, pulling specified images, running containers, validating if a container is running, and checking logs of containers.

## Features

- **Stop all running Docker containers**: Stops all running containers on your system.
- **Delete all Docker images**: Deletes all images from your Docker host.
- **Pull Docker images**: Pulls a predefined list of Docker images (`debian`, `rockylinux:8`, `nginx`).
- **Run a container**: Runs a specified container by name. If the container doesn't exist, it will be pulled and started.
- **Validate if a container is running**: Validates if a container is currently running by its name.
- **View container logs**: Displays the logs of a specified container.

## Usage

### Options:

```bash
Usage: ./docker_script.sh [--stop-all] [--delete-all] [--install] [--run <container_name>] [--validate <container_name>] [--logs <container_name>] [--help]
```

### Available Options:

- `--stop-all`: Stop all running Docker containers.
- `--delete-all`: Delete all Docker images on the host.
- `--install`: Pull the specified Docker images (`debian`, `rockylinux:8`, `nginx`).
- `--run <container_name>`: Run the specified container by name. If it doesn't exist, it will be pulled and started.
- `--validate <container_name>`: Validate if a container is running by name.
- `--logs <container_name>`: Display the logs of the specified container.
- `--help`: Display this help message.

### Example Commands:

- **Stop all running containers**:
  ```bash
  ./docker_script.sh --stop-all
  ```

- **Delete all Docker images**:
  ```bash
  ./docker_script.sh --delete-all
  ```

- **Pull and install Docker images**:
  ```bash
  ./docker_script.sh --install
  ```

- **Run a specified container** (e.g., `nginx`):
  ```bash
  ./docker_script.sh --run nginx
  ```

- **Validate if a specified container is running** (e.g., `nginx`):
  ```bash
  ./docker_script.sh --validate nginx
  ```

- **View logs of a specified container** (e.g., `nginx`):
  ```bash
  ./docker_script.sh --logs nginx
  ```

### Image List:

- `debian`
- `rockylinux:8`
- `nginx`

## Requirements:

- Docker must be installed and available in your system's PATH.

## License:

free to use for everyone.
