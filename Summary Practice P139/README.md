
# Practice p139

# Docker Utility Script

## Description
This script provides several Docker utilities for managing containers, volumes, and networks. It includes options for:
- Creating and managing Docker volumes
- Mounting volumes to containers
- Checking if volumes or folders exist inside containers
- Listing containers, volumes, and their mounts
- Deleting all Docker containers and images
- Killing specific containers
- Verifying storage and removing volumes

## Features
- `--delete-all` - Deletes all Docker containers and images on the host.
- `--create-volume <volume_name>` - Creates a Docker volume with the specified name.
- `--mount <container_image> <volume_name>` - Pulls a container image (if not available), runs the container, and mounts the specified volume.
- `--kill <container_name>` - Stops and removes the specified container.
- `--verify-volume <volume_name>` - Verifies if a Docker volume exists.
- `--test-folder <container_name> <folder_path>` - Checks if a specified folder exists inside a running container.
- `--list-volumes` - Lists all Docker volumes.
- `--mounts` - Displays all containers and their mounted volumes.
- `--remove-volume <volume_name>` - Removes the specified Docker volume.

## Usage
### Example Commands:
- Delete all Docker containers and images:
    ```bash
    ./docker_utility.sh --delete-all
    ```
- Create a Docker volume:
    ```bash
    ./docker_utility.sh --create-volume my_volume
    ```
- Mount a volume to a container:
    ```bash
    ./docker_utility.sh --mount nginx my_volume
    ```
- Kill a container:
    ```bash
    ./docker_utility.sh --kill my_container
    ```

## License
This project is licensed under the [MIT License](LICENSE). Free to use.

