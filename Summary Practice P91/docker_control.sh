#!/bin/bash
######################################
# Created by : Meir
# Purpose : Docker Summary Practice p91
# Date : 19/4/2025
# Version : 1
######################################

set -o errexit
set -o pipefail
set -o nounset

# Function to display usage help
usage() {
    echo "Usage: $0 [--stop-all] [--delete-all] [--install] [--run <container_name>] [--validate <container_name>] [--logs <container_name>] [--search <image_name>] [--help]"
    echo
    echo "Options:"
    echo "  --stop-all               Stop all running Docker containers."
    echo "  --delete-all             Delete all Docker images on the host."
    echo "  --install                Pull the specified Docker images."
    echo "  --run <container_name>   Run the specified container (pulls image if not found)."
    echo "  --validate <name>        Validate that a container is running by name."
    echo "  --logs <name>            View logs of a specific container."
    echo "  --search <image_name>    Search Docker Hub for container images (limit 100)."
    echo "  --help                   Display this help message."
    echo
    echo "Examples:"
    echo "  $0 --stop-all"
    echo "  $0 --delete-all"
    echo "  $0 --install"
    echo "  $0 --run nginx"
    echo "  $0 --validate nginx"
    echo "  $0 --logs nginx"
    echo "  $0 --search nginx"
    echo
    echo "Image List (for --install):"
    echo "  debian"
    echo "  rockylinux:8"
    echo "  nginx"
    exit 0
}

# Function to print messages
print_msg() {
    echo "$1"
}

# Ensure Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not found in the system's PATH."
    exit 1
fi

# Show usage if no arguments
if [[ $# -eq 0 ]]; then
    usage
fi

# Parse arguments
case "$1" in
    --stop-all)
        if [ "$(sudo docker ps -q)" ]; then
            sudo docker stop $(sudo docker ps -q)
            print_msg "All running containers have been stopped."
        else
            print_msg "No running containers."
        fi
        ;;
    --delete-all)
        if [ "$(sudo docker images -q)" ]; then
            sudo docker rmi -f $(sudo docker images -q)
            print_msg "All Docker images have been deleted."
        else
            print_msg "No images to delete."
        fi
        ;;
    --install)
        print_msg "Pulling the specified Docker images..."
        images=("debian" "rockylinux:8" "nginx")
        for image in "${images[@]}"; do
            print_msg "Pulling image: $image..."
            if sudo docker pull "$image"; then
                print_msg "$image pulled successfully."
            else
                print_msg "Failed to pull $image."
            fi
        done
        ;;
    --run)
        container_name=${2:-}
        if [[ -z "$container_name" ]]; then
            echo "Please provide a container name after --run"
            exit 1
        fi
        if ! sudo docker image inspect "$container_name" &> /dev/null; then
            print_msg "Image '$container_name' not found locally. Pulling..."
            sudo docker pull "$container_name"
        fi
        print_msg "Running container: $container_name"
        sudo docker run -dit --name "$container_name-instance" "$container_name"
        ;;
    --validate)
        container_name=${2:-}
        if [[ -z "$container_name" ]]; then
            echo "Please provide a container name after --validate"
            exit 1
        fi
        if sudo docker ps --format '{{.Names}}' | grep -qw "$container_name"; then
            print_msg "Container '$container_name' is running."
        else
            print_msg "Container '$container_name' is NOT running."
        fi
        ;;
    --logs)
        container_name=${2:-}
        if [[ -z "$container_name" ]]; then
            echo "Please provide a container name after --logs"
            exit 1
        fi
        print_msg "Showing logs for container '$container_name':"
        sudo docker logs "$container_name"
        ;;
    --search)
        image_name=${2:-}
        if [[ -z "$image_name" ]]; then
            echo "Please provide an image name after --search"
            exit 1
        fi
        print_msg "Searching Docker Hub for images matching: $image_name..."
        echo "Showing up to 100 results. ⭐ = Community favorites (more stars = more trusted/popular)."
        echo
        count=1
        sudo docker search "$image_name" --limit 100 --format "{{.Name}} | {{.Description}} | ⭐ {{.StarCount}} | Official: {{.IsOfficial}}" | while read -r line; do
            printf "%3d. %s\n" "$count" "$line"
            ((count++))
        done
        ;;
    --help)
        usage
        ;;
    *)
        echo "Unknown option: $1"
        usage
        ;;
esac
