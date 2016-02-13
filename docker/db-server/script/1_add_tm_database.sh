#!/bin/sh

export PGUSER=postgres
psql <<- EOSQL
    CREATE USER osmtm WITH PASSWORD 'osmtm' SUPERUSER;
    CREATE DATABASE osmtm OWNER osmtm ENCODING 'UTF8' TEMPLATE template0;
    GRANT ALL PRIVILEGES ON DATABASE osmtm TO osmtm;
EOSQL

psql -d osmtm <<- EOSQL
    CREATE EXTENSION postgis;
    CREATE EXTENSION hstore;
EOSQL
