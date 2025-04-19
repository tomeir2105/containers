#!/bin/bash
######################################
# Created by : Meir
# Purpose : Docker Cleanup, Network Creation, Container Run, and List Networks/Containers
# Date : 19/4/2025
# Version : 1
######################################

set -o errexit
set -o pipefail
set -o nounset

# Function to display usage help
usage() {
    echo "Usage: $0 [--delete-all] [--create-network <network_name>] [--run <container_name> <network_name>] [--connect <container_name>] [--list] [--help]"
    echo
    echo "Options:"
    echo "  --delete-all             Delete all Docker images and containers on the host."
    echo "  --create-network <network_name>   Create a Docker network with the specified name (default: bridge)."
    echo "  --run <container_name> <network_name>   Run a container by name and connect it to the specified network."
    echo "  --connect <container_name>   Connect the specified container to the default network (bridge)."
    echo "  --list                   List all Docker networks and the containers connected to them."
    echo "  --help                   Display this help message."
    echo
    echo "Examples:"
    echo "  $0 --delete-all"
    echo "  $0 --create-network my-network"
    echo "  $0 --run nginx bridge"
    echo "  $0 --connect my-container"
    echo "  $0 --list"
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

# Default network (Docker's default network)
default_network="bridge"

# Parse arguments
case "$1" in
    --delete-all)
        # Stop and remove all containers
        if [ "$(sudo docker ps -aq)" ]; then
            sudo docker rm -f $(sudo docker ps -aq)
            print_msg "All containers have been removed."
        else
            print_msg "No containers to remove."
        fi

        # Delete all images on your host
        if [ "$(sudo docker images -q)" ]; then
            sudo docker rmi -f $(sudo docker images -q)
            print_msg "All Docker images have been deleted."
        else
            print_msg "No images to delete."
        fi

        # Run docker system prune to remove unused data (containers, networks, volumes, images)
        print_msg "Running docker system prune to clean up unused resources..."
        sudo docker system prune -a --volumes -f
        print_msg "Docker system prune completed. All unused containers, images, networks, and volumes are removed."
        ;;
    --create-network)
        network_name=${2:-$default_network}
        if [[ -z "$network_name" ]]; then
            echo "Please provide a network name after --create-network"
            exit 1
        fi

        # Create the Docker network
        print_msg "Creating Docker network: $network_name"
        if sudo docker network create "$network_name"; then
            print_msg "Network '$network_name' created successfully."
        else
            print_msg "Failed to create network '$network_name'."
        fi
        ;;
    --run)
        # Ensure both container and network names are provided
        if [[ -z "${2:-}" || -z "${3:-}" ]]; then
            echo "Please provide both a container name and a network name after --run"
            exit 1
        fi

        container_name=$2
        network_name=$3

        # Check if the network exists
        if ! sudo docker network inspect "$network_name" &> /dev/null; then
            print_msg "Network '$network_name' does not exist. Creating it now..."
            sudo docker network create "$network_name"
            print_msg "Network '$network_name' created successfully."
        fi

        # Run the container and connect it to the network
        print_msg "Running container '$container_name' and connecting it to network '$network_name'..."
        sudo docker run -dit --name "$container_name-instance" --network "$network_name" "$container_name"
        print_msg "Container '$container_name' is running and connected to network '$network_name'."
        ;;
    --connect)
        # Ensure container name is provided
        if [[ -z "${2:-}" ]]; then
            echo "Please provide a container name after --connect"
            exit 1
        fi

        container_name=$2

        # Check if the container exists and is running
        if ! sudo docker ps -q -f "name=$container_name" &> /dev/null; then
            print_msg "Container '$container_name' is not running or does not exist."
            print_msg "Listing all containers..."
            sudo docker ps -a
            exit 1
        fi

        # Connect the container to the default network (bridge)
        print_msg "Connecting container '$container_name' to network '$default_network'..."
        sudo docker network connect "$default_network" "$container_name"
        print_msg "Container '$container_name' is now connected to the default network '$default_network'."
        ;;
    --list)
        # List all networks and their connected containers
        print_msg "Listing all Docker networks and connected containers..."
        networks=$(sudo docker network ls -q)
        if [ -z "$networks" ]; then
            print_msg "No networks found."
        else
            for network in $networks; do
                print_msg "Network: $network"
                containers=$(sudo docker network inspect "$network" -f '{{range .Containers}}{{.Name}}{{end}}')
                if [ -z "$containers" ]; then
                    print_msg "  No containers connected."
                else
                    print_msg "  Connected containers: $containers"
                fi
            done
        fi
        ;;
    --help)
        usage
        ;;
    *)
        echo "Unknown option: $1"
        usage
        ;;
esac
