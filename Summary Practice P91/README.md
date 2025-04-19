
# Docker Management Scripts

## Overview
This two scripts are designed to manage Docker containers and images.
- docker_control.sh - provides options to stop containers, delete images, pull images, validate containers, check logs, and search Docker Hub repositories. It is a simple yet powerful tool for Docker management and automation.
- docker_net.sh -  runs 3 specified containers with different predefined names under specific my_network.

# Docker Control script info
## Features
- Stop all running containers.
- Delete all containers and images from the host.
- Pull specific Docker images.
- Run containers (pull image if not available locally).
- Validate if a container is running.
- View logs of a specific container.
- Search Docker Hub for container images.
- Show release information of a Docker image.
- Clean up unused Docker data using `docker system prune`.

## Usage
```bash
./docker_script.sh [options]
```

## Options
### `--stop-all`
Stop all running Docker containers.

### `--delete-all`
Delete all Docker containers and images from the host, followed by a system prune to remove unused data (containers, networks, volumes, images).

### `--install`
Pull the specified Docker images:
- `debian`
- `rockylinux:8`
- `nginx`

### `--run <container_name>`
Run the specified container in detached and interactive mode. If the image is not found locally, it will be pulled from Docker Hub.

### `--validate <container_name>`
Validate if the specified container is running.

### `--logs <container_name>`
View the logs of a specific container.

### `--search <image_name>`
Search Docker Hub for images that match the specified name. Limited to 100 results.

### `--release-info <image_name>`
Run the specified container and print `/etc/*release` to display the image's version and distribution information.

### `--help`
Display this help message.

## Examples
- **Stop all running containers**:
  ```bash
  ./docker_script.sh --stop-all
  ```
- **Delete all containers and images**:
  ```bash
  ./docker_script.sh --delete-all
  ```
- **Install specified images**:
  ```bash
  ./docker_script.sh --install
  ```
- **Run a container**:
  ```bash
  ./docker_script.sh --run nginx
  ```
- **Validate if a container is running**:
  ```bash
  ./docker_script.sh --validate nginx
  ```
- **View logs of a container**:
  ```bash
  ./docker_script.sh --logs nginx
  ```
- **Search Docker Hub for an image**:
  ```bash
  ./docker_script.sh --search nginx
  ```
- **Show release info for an image**:
  ```bash
  ./docker_script.sh --release-info rockylinux:8
  ```

## Image List (for `--install`):
- `debian`
- `rockylinux:8`
- `nginx`

## License
Free to use
