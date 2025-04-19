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

