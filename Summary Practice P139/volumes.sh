#!/bin/bash
######################################
# Created by : Meir
# Purpose : Volumes Utility Script
# Date : 19/4/2025
# Version : 1
######################################

set -o errexit
set -o pipefail
set -o nounset

usage() {
    echo "Usage: $0 [--delete-all] [--create-volume <volume_name>] [--mount <container_image> <volume_name>] [--kill <container_name>] [--verify-volume <volume_name>] [--test-folder <container_name> <folder_path>] [--list-volumes] [--mounts] [--remove-volume <volume_name>]"
    echo
    echo "Options:"
    echo "  --delete-all                         Delete all Docker containers and images on the host."
    echo "  --create-volume <volume_name>       Create a Docker volume with the specified name."
    echo "  --mount <container_image> <volume_name>  Pull image (if missing), run container, and mount volume at /mnt/<volume>."
    echo "  --kill <container_name>             Stop and remove the specified container."
    echo "  --verify-volume <volume_name>       Check if a Docker volume exists."
    echo "  --test-folder <container_name> <folder_path>  Check if folder exists inside a running container."
    echo "  --list-volumes                      List all Docker volumes."
    echo "  --mounts                            Show all containers and their mounted volume names and paths."
    echo "  --remove-volume <volume_name>       Remove a specific Docker volume."
    echo
    exit 0
}

print_msg() {
    echo "$1"
}

list_containers() {
    echo "Available containers:"
    sudo docker ps -a --format "  - {{.Names}}"
}

confirm_action() {
    read -p "Are you sure? (y/n): " confirmation
    if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
        print_msg "Action cancelled."
        exit 1
    fi
}

if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not found in the system's PATH."
    exit 1
fi

if [[ $# -eq 0 ]]; then
    usage
fi

case "$1" in
    --delete-all)
        print_msg "This will remove all containers and images."
        confirm_action

        if [ "$(sudo docker ps -aq)" ]; then
            sudo docker rm -f $(sudo docker ps -aq)
            print_msg "All containers have been removed."
        else
            print_msg "No containers to remove."
        fi

        if [ "$(sudo docker images -q)" ]; then
            sudo docker rmi -f $(sudo docker images -q)
            print_msg "All Docker images have been deleted."
        else
            print_msg "No images to delete."
        fi

        print_msg "Running docker system prune..."
        sudo docker system prune -a --volumes -f
        print_msg "Prune completed."
        ;;

    --create-volume)
        if [[ -z "${2:-}" ]]; then
            echo "Please provide a volume name after --create-volume"
            exit 1
        fi

        volume_name=$2

        if sudo docker volume inspect "$volume_name" &> /dev/null; then
            print_msg "Volume '$volume_name' already exists."
        else
            print_msg "Creating volume '$volume_name'..."
            sudo docker volume create "$volume_name"
            print_msg "Volume created."
        fi
        ;;

    --mount)
        if [[ -z "${2:-}" || -z "${3:-}" ]]; then
            echo "Usage: --mount <container_image> <volume_name>"
            exit 1
        fi

        container_image=$2
        volume_name=$3
        container_instance="${container_image}-mounted"

        if ! sudo docker image inspect "$container_image" &> /dev/null; then
            print_msg "Image not found. Pulling '$container_image'..."
            sudo docker pull "$container_image"
        fi

        if sudo docker ps -a --filter "name=^/${container_instance}$" -q; then
            print_msg "Removing existing container '$container_instance'..."
            sudo docker rm -f "$container_instance"
        fi

        if ! sudo docker volume inspect "$volume_name" &> /dev/null; then
            print_msg "Creating volume '$volume_name'..."
            sudo docker volume create "$volume_name"
        fi

        print_msg "Running container '$container_instance' with volume mounted..."
        sudo docker run -dit --name "$container_instance" -v "$volume_name:/mnt/$volume_name" "$container_image"
        print_msg "Container '$container_instance' is running."
        ;;

    --kill)
        if [[ -z "${2:-}" ]]; then
            echo "Please provide a container name after --kill"
            exit 1
        fi

        container_name=$2

        if ! sudo docker ps -a --filter "name=^/${container_name}$" -q > /dev/null; then
            print_msg "Container '$container_name' not found."
            list_containers
            exit 1
        fi

        print_msg "Stopping and removing '$container_name'..."
        confirm_action
        sudo docker rm -f "$container_name"
        print_msg "Container removed."
        ;;

    --verify-volume)
        if [[ -z "${2:-}" ]]; then
            echo "Please provide a volume name."
            exit 1
        fi

        volume_name=$2

        if sudo docker volume inspect "$volume_name" &> /dev/null; then
            print_msg "Docker volume '$volume_name' exists."
        else
            print_msg "Docker volume '$volume_name' does not exist."
        fi
        ;;

    --test-folder)
        if [[ -z "${2:-}" || -z "${3:-}" ]]; then
            echo "Usage: --test-folder <container_name> <folder_path>"
            exit 1
        fi

        container_name=$2
        folder_path=$3

        if ! sudo docker ps -a --filter "name=^/${container_name}$" -q > /dev/null; then
            print_msg "Container '$container_name' not found."
            list_containers
            exit 1
        fi

        if ! sudo docker ps --filter "name=^/${container_name}$" --filter "status=running" -q > /dev/null; then
            print_msg "Container '$container_name' is not running."
            exit 1
        fi

        if sudo docker exec "$container_name" test -d "$folder_path"; then
            print_msg "Folder '$folder_path' exists in container '$container_name'."
        else
            print_msg "Folder '$folder_path' not found in container '$container_name'."
        fi
        ;;

    --list-volumes)
        print_msg "Docker volumes:"
        volumes=$(sudo docker volume ls -q)
        if [[ -z "$volumes" ]]; then
            print_msg "No volumes found."
        else
            for vol in $volumes; do
                echo " - $vol"
            done
        fi
        ;;

    --mounts)
        print_msg "Listing container mounts:"
        containers=$(sudo docker ps -a --format '{{.Names}}')

        if [[ -z "$containers" ]]; then
            print_msg "No containers found."
        else
            for container in $containers; do
                echo "Container: $container"
                sudo docker inspect "$container" \
                    --format '{{range .Mounts}}  Volume: {{.Name}} → {{.Destination}}{{println}}{{end}}' || echo "  No volume mounts."
            done
        fi
        ;;

    --remove-volume)
        if [[ -z "${2:-}" ]]; then
            echo "Please provide a volume name after --remove-volume"
            exit 1
        fi

        volume_name=$2

        if ! sudo docker volume inspect "$volume_name" &> /dev/null; then
            print_msg "Volume '$volume_name' does not exist."
            exit 1
        fi

        print_msg "This will remove volume '$volume_name'."
        confirm_action
        print_msg "Removing volume '$volume_name'..."
        sudo docker volume rm "$volume_name"
        print_msg "Volume '$volume_name' has been removed."
        ;;

    --help)
        usage
        ;;

    *)
        echo "Unknown option: $1"
        usage
        ;;
esac
