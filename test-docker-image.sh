#!/bin/sh

#docker-machine create --driver virtualbox --virtualbox-hostonly-cidr "192.168.59.1/24" default
docker stop tm-web
docker rm tm-web
docker build --tag="tm-web" .

docker run --name tm-web -p 6543:6543 -d \
-e DB_CONNECTION=postgresql://osmtm:osmtm@192.168.59.100/osmtm \
-e COMMENT_PREFIX=#mapforenvironment \
tm-web
#-e INIT_DB=1 \
