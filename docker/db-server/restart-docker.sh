#!/bin/sh
docker stop tm-db
docker rm tm-db
docker build --tag="tm-db" .
docker run --name tm-db -p 5432:5432 -d -e POSTGRES_PASSWORD=tm tm-db
