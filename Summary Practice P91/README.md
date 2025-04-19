# Docker Management Script

This script provides a simple command-line interface for managing Docker containers and images. It supports stopping all running containers, deleting all Docker images, pulling a set of specified Docker images, and displaying usage help.

## Features

- **Stop all running containers**: Stops all currently running Docker containers.
- **Delete all Docker images**: Removes all Docker images from the host.
- **Pull specified images**: Pulls a set of predefined Docker images (`debian`, `rockylinux:8`, `nginx`).
- **Help**: Displays usage instructions and available options.

## Prerequisites

Ensure that Docker is installed and accessible from the command line.

To check if Docker is installed, run:

```bash
docker --version
