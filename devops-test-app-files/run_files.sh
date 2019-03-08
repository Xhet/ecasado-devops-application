#!/bin/env bash

echo "exporting needed environment variables"
source /.env
BASE_PWD=`pwd`
echo "getting files service up"

docker-compose up -d --build --force-recreate
sleep 15
echo "WAITING for service"
curl -vv http://localhost:3081/files

echo "getting files service up"


