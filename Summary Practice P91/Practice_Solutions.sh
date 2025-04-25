# With one line commands, stop all containers.
docker stop $(docker ps -q)
# Delete all images on your host.
docker rmi -f $(docker images -q)
# Pull next list of containers: Debian, Rocky, Nginx
docker pull debian && docker pull rockylinux && docker pull nginx

--- USING SCRIPT ---

## With one line commands, stop all containers.
./docker_script.sh --stop-all

## Delete all images on your host.
./docker_script.sh --delete-all

## Pull next list of containers: Debian, Rocky, Nginx
./docker_script.sh --install

