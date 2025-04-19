#!/bin/bash
######################################
# Created by : Meir
# Purpose : Docker Summary Practice p91
# Date : 19/4/2025
# Version : 1
#set -x
set -o errexit
set -o pipefail
set -o nounset
#####################################

# Function to display usage help
usage() {
    echo "Usage: $0 [--stop-all] [--delete-all] [--install] [--run <container_name>] [--help]"
    echo
    echo "Options:"
    echo "  --stop-all      Stop all running Docker containers."
    echo "  --delete-all    Delete all Docker images on the host."
    echo "  --install       Pull the specified Docker images."
    echo "  --run <container_name>  Run the specified container by name. If it doesn't exist, it will be pulled and started."
    echo "  --help          Display this help message."
    echo
    echo "Examples:"
    echo "  $0 --stop-all      # Stop all running containers."
    echo "  $0 --delete-all    # Delete all Docker images."
    echo "  $0 --install       # Pull the specified Docker images."
    echo "  $0 --run nginx     # Run the 'nginx' container (pulls it if not exists)."
    echo "  $0 --help          # Show help usage."
    echo
    echo "Image List:"
    echo "  debian"
    echo "  rockylinux:8"
    echo "  nginx"
    exit 0
}

# Function to print messages
print_msg() {
    echo "$1"
}

# Check if Docker command exists
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed or not found in the system's PATH."
    exit 1
fi

# Check if --help or no option is passed
if [[ "$1" == "--help" ]] || [[ -z "$1" ]]; then
    usage
fi

# Check if the --stop-all parameter is passed
if [[ "$1" == "--stop-all" ]]; then
    # Stop all containers.
    if [ "$(sudo docker ps -q)" ]; then
        sudo docker stop $(sudo docker ps -q)
        print_msg "All running containers have been stopped."
    else
        print_msg "No running containers."
    fi
fi

# Check if the --delete-all parameter is passed
if [[ "$1" == "--delete-all" ]]; then
    # Delete all images on your host.
    if [ "$(sudo docker images -q)" ]; then
        sudo docker rmi -f $(sudo docker images -q)
        print_msg "All Docker images have been deleted."
    else
        print_msg "No images to delete."
    fi
fi

# Check if the --install parameter is passed
if [[ "$1" == "--install" ]]; then
    # Pull Docker images
    print_msg "Pulling the specified Docker images..."

    # Define the list of images and versions (excluding ubuntu:20.04 and alpine:latest)
    images=("debian" "rockylinux:8" "nginx")

    # Loop through each image and pull it
    for image in "${images[@]}"; do
        print_msg "Pulling image: $image..."
        if sudo docker pull "$image"; then
            print_msg "$image pulled successfully."
        else
            print_msg "Failed to pull $image."
        fi
    done
fi

# Check if the --run parameter is passed
if [[ "$1" == "--run" ]]; then
    # Check if container name is provided
    if [[ -z "$2" ]]; then
        print_msg "Please specify a container name to run."
        exit 1
    fi

    container_name="$2"

    # Check if the container is already running
    if [[ "$(sudo docker ps -q -f name=$container_name)" ]]; then
        print_msg "The container '$container_name' is already running."
    else
        # Check if the container exists (stopped but not deleted)
        if [[ "$(sudo docker ps -aq -f name=$container_name)" ]]; then
            print_msg "The container '$container_name' exists but is stopped. Restarting..."
            sudo docker start "$container_name"
        else
            # If the container does not exist, pull the image and run the container
            print_msg "The container '$container_name' does not exist. Pulling the image and starting the container..."
            if sudo docker pull "$container_name"; then
                sudo docker run -d --name "$container_name" "$container_name"
                print_msg "Container '$container_name' started successfully."
            else
                print_msg "Failed to pull the image for container '$container_name'."
            fi
        fi
    fi
fi
