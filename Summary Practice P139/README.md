
# Docker Utility Script

## Description
This script provides several utilities to manage Docker containers, volumes, and networks. It allows for operations such as creating volumes, mounting volumes to containers, killing containers, checking storage, verifying folder existence inside running containers, listing containers and volumes, and removing Docker resources.

### Features:
- Create, list, and remove Docker volumes.
- Mount a volume to a container and run the container.
- Kill a container by name.
- Verify if a Docker volume or folder in a container exists.
- List all running containers and their mounted volumes.
- Remove specific Docker volumes.
- Delete all Docker containers, images, and unused resources.

## Usage

### General Syntax:
```
./docker_utility.sh [OPTION] [PARAMETERS]
```

### Options:
1. **`--help`**
   - Displays the help message for the script, listing all available options.
   - **Example:**
     ```bash
     ./docker_utility.sh --help
     ```
   - **Output:**
     ```
     Usage: ./docker_utility.sh [OPTION] [PARAMETERS]

     Options:
       --delete-all             Delete all Docker containers and images on the host.
       --create-volume <volume_name>   Create a Docker volume with the specified name.
       --mount <container_image> <volume_name>   Pull image (if missing), run container, and mount volume.
       --kill <container_name>   Stop and remove the specified container.
       --verify-volume <volume_name>   Verify if a Docker volume exists.
       --test-folder <container_name> <folder_path>   Check if folder exists inside a running container.
       --list-volumes            List all Docker volumes.
       --mounts                  List all containers and their mounted volumes.
       --remove-volume <volume_name>   Remove a specific Docker volume.
       --help                    Display this help message.
     ```

2. **`--delete-all`**
   - Deletes all Docker containers and images on the host and runs `docker system prune`.
   - **Example:**
     ```bash
     ./docker_utility.sh --delete-all
     ```
   - **Output:**
     ```
     This will remove all containers and images.
     Are you sure? (y/n): y
     All containers have been removed.
     All Docker images have been deleted.
     Running docker system prune...
     Prune completed.
     ```

3. **`--create-volume <volume_name>`**
   - Creates a Docker volume with the specified name.
   - **Example:**
     ```bash
     ./docker_utility.sh --create-volume my_volume
     ```
   - **Output:**
     ```
     Creating volume 'my_volume'...
     Volume created.
     ```

4. **`--mount <container_image> <volume_name>`**
   - Pulls the container image (if missing), runs a container from the image, and mounts the specified volume.
   - **Example:**
     ```bash
     ./docker_utility.sh --mount nginx my_volume
     ```
   - **Output:**
     ```
     Image not found. Pulling 'nginx'...
     Running container 'nginx-mounted' with volume mounted...
     Container 'nginx-mounted' is running.
     ```

5. **`--kill <container_name>`**
   - Stops and removes the specified container.
   - **Example:**
     ```bash
     ./docker_utility.sh --kill my_container
     ```
   - **Output:**
     ```
     Stopping and removing 'my_container'...
     Are you sure? (y/n): y
     Container removed.
     ```

6. **`--verify-volume <volume_name>`**
   - Verifies if a Docker volume exists.
   - **Example:**
     ```bash
     ./docker_utility.sh --verify-volume my_volume
     ```
   - **Output:**
     ```
     Docker volume 'my_volume' exists.
     ```

7. **`--test-folder <container_name> <folder_path>`**
   - Checks if the specified folder exists inside a running container.
   - **Example:**
     ```bash
     ./docker_utility.sh --test-folder my_container /mnt/data
     ```
   - **Output:**
     ```
     Container 'my_container' is running.
     Folder '/mnt/data' exists in container 'my_container'.
     ```

8. **`--list-volumes`**
   - Lists all Docker volumes on the host.
   - **Example:**
     ```bash
     ./docker_utility.sh --list-volumes
     ```
   - **Output:**
     ```
     Docker volumes:
     - my_volume
     - another_volume
     ```

9. **`--mounts`**
   - Lists all containers along with their mounted volume names and paths.
   - **Example:**
     ```bash
     ./docker_utility.sh --mounts
     ```
   - **Output:**
     ```
     Container: nginx-mounted
       Volume: my_volume → /mnt/my_volume
     ```

10. **`--remove-volume <volume_name>`**
    - Removes the specified Docker volume.
    - **Example:**
      ```bash
      ./docker_utility.sh --remove-volume my_volume
      ```
    - **Output:**
      ```
      This will remove volume 'my_volume'.
      Are you sure? (y/n): y
      Removing volume 'my_volume'...
      Volume 'my_volume' has been removed.
      ```

## License
Free to use.
