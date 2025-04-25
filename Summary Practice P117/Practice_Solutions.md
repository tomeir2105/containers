# Clean all containers and image from your host
sudo docker rm -f $(sudo docker ps -aq)
sudo docker rmi -f $(sudo docker images -q)

# Create docker network named vaio-net
sudo docker network create vaio-net

# Run alpine container on custom docker network named vaio-net
docker run -dit --name alpine-container --network vaio-net alpine

# Run nginx container on custom docker network named vaio-net
docker run -dit --name nginx-container --network vaio-net nginx

# Run ubuntu/apache2 container on default docker network
docker run -dit --name apache-container ubuntu bash
docker exec apache-container apt update
docker exec apache-container apt install -y apache2

# Run from alpine container ping command to test connectivity with ubuntu/apache2
# GET IP OF CONTAINER - 
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' apache-container
docker exec -it alpine-container ping <IP-ADDRESS-FROM-ABOVE>


# BONUS: connect already running ubuntu/apache2 container to vaio-net
docker network connect vaio-net apache-container
docker exec -it alpine-container ping apache-container

# Delete all the containers images and network
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)
docker network rm vaio-net

-------  WITH SCRIPT ------


## Clean all containers and image from your host
./docker_net.sh --delete-all

## Create docker network named vaio-net
./docker_net.sh --create-network vaio-net

## Run alpine container on custom docker network named vaio-net
./docker_net.sh --connect alpine vaio-net
./docker_net.sh --list

## Run nginx container on custom docker network named vaio-net
./docker_net.sh --connect nginx vaio-net
./docker_net.sh --list

## Run ubuntu/apache2 container on default docker network
./docker_net.sh --connect ubuntu/apache2

## Run from alpine container ping command to test connectivity with ubuntu/apache2
./docker_net.sh --ip vaio-net    # Show IP addresses of containers
./docker_net.sh --list    # List all Docker networks and the containers
./docker_net.sh --ping alpine-instance 172.18.0.2

## BONUS: connect already running ubuntu/apache2 container to vaio-net
./docker_net.sh --connect ubuntu/apache2 vaio-net

## Delete all the containers images and network
./docker_net.sh --delete-all

