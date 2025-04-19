#!/bin/bash
######################################
# Created by : Meir
# Purpose : Docker Summary Practice p92 Bonus
# Date : 19/4/2025
# Version : 1
######################################

# Check if exactly 3 container names are provided
if [ "$#" -ne 3 ]; then
    echo "Error: You must provide exactly 3 container names."
    echo "Usage: $0 container_name_1 container_name_2 container_name_3"
    exit 1
fi

# Get the input container names
CONTAINER_NAME_1=$1
CONTAINER_NAME_2=$2
CONTAINER_NAME_3=$3

# Network name (Change as needed)
NETWORK_NAME="my_network"

# Docker images (If the images are not available locally, they will be pulled)
IMAGE_1=$CONTAINER_NAME_1
IMAGE_2=$CONTAINER_NAME_2
IMAGE_3=$CONTAINER_NAME_3

# Function to check if a Docker image exists locally, and pull it if it doesn't
check_and_pull_image() {
    local image=$1
    if ! docker image inspect "$image" > /dev/null 2>&1; then
        echo "Image '$image' not found locally. Pulling from Docker repository..."
        docker pull "$image"
    else
        echo "Image '$image' found locally."
    fi
}

# Function to create a Docker network if it doesn't exist
create_network_if_needed() {
    if ! docker network inspect "$NETWORK_NAME" > /dev/null 2>&1; then
        echo "Network '$NETWORK_NAME' not found. Creating network..."
        docker network create "$NETWORK_NAME"
    else
        echo "Network '$NETWORK_NAME' exists."
    fi
}

# Check and pull images
check_and_pull_image $IMAGE_1
check_and_pull_image $IMAGE_2
check_and_pull_image $IMAGE_3

# Create the network if needed
create_network_if_needed

# Run the containers with predefined names under the specific network
docker run -d --name $CONTAINER_NAME_1 --network $NETWORK_NAME $IMAGE_1
docker run -d --name $CONTAINER_NAME_2 --network $NETWORK_NAME $IMAGE_2
docker run -d --name $CONTAINER_NAME_3 --network $NETWORK_NAME $IMAGE_3

# Confirm that the containers are running
echo "Running containers:"
docker ps --filter "name=$CONTAINER_NAME_1"
docker ps --filter "name=$CONTAINER_NAME_2"
docker ps --filter "name=$CONTAINER_NAME_3"
