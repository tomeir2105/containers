
# Docker Management Script
This script provides a simple command-line interface for managing Docker containers and images. It supports stopping all running containers, deleting all Docker images, pulling a set of specified Docker images, and displaying usage help.

## Features
- **Stop all running containers**: Stops all currently running Docker containers.
- **Delete all Docker images**: Removes all Docker images from the host.
- **Pull specified images**: Pulls a set of predefined Docker images (`debian`, `rockylinux:8`, `nginx`).
- **Help**: Displays usage instructions and available options.

## Prerequisites
Ensure that Docker is installed and accessible from the command line (the script checks also).
To check if Docker is installed, run:

```bash
docker --version
```

If Docker is not installed, follow the [official Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.

## Usage

You can run the script with one of the following options:

### 1. **Display Help**
To display the usage instructions:

```bash
./docker_manage.sh --help
```

### 2. **Stop All Running Containers**
To stop all running Docker containers:

```bash
./docker_manage.sh --stop-all
```

### 3. **Delete All Docker Images**
To delete all Docker images on the host:

```bash
./docker_manage.sh --delete-all
```

### 4. **Pull Specified Docker Images**
To pull the following images:
- `debian`
- `rockylinux:8`
- `nginx`

Use the following command:

```bash
./docker_manage.sh --install
```

### 5. **Examples**

#### Displaying Help:

```bash
$ ./docker_manage.sh --help
Usage: ./docker_manage.sh [--stop-all] [--delete-all] [--install] [--help]

Options:
  --stop-all      Stop all running Docker containers.
  --delete-all    Delete all Docker images on the host.
  --install       Pull the specified Docker images.
  --help          Display this help message.

Examples:
  ./docker_manage.sh --stop-all      # Stop all running containers.
  ./docker_manage.sh --delete-all    # Delete all Docker images.
  ./docker_manage.sh --install       # Pull the specified Docker images.
  ./docker_manage.sh --help          # Show help usage.

Image List:
  debian
  rockylinux:8
  nginx
```

#### Stopping All Containers:

```bash
$ ./docker_manage.sh --stop-all
All running containers have been stopped.
```

#### Deleting All Images:

```bash
$ ./docker_manage.sh --delete-all
All Docker images have been deleted.
```

#### Pulling Specified Images:

```bash
$ ./docker_manage.sh --install
Pulling the specified Docker images...
Pulling image: debian...
debian pulled successfully.
Pulling image: rockylinux:8...
rockylinux:8 pulled successfully.
Pulling image: nginx...
nginx pulled successfully.
```

## Script Details

### 1. **Stop All Running Containers (`--stop-all`)**
This option stops all containers that are currently running.

### 2. **Delete All Docker Images (`--delete-all`)**
This option removes all Docker images from the system. Be cautious with this command as it will delete all your local images.

### 3. **Pull Images (`--install`)**
The script pulls the following images:
- `debian`
- `rockylinux:8`
- `nginx`

This option will attempt to download these images from Docker Hub. If the image is already pulled, it will be skipped.

### 4. **Help (`--help`)**
The `--help` option displays the usage of the script, including available commands and examples.

## License
Free to use
