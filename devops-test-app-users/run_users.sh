#!/bin/env bash

echo "exporting needed environment variables"
source /.env
BASE_PWD=`pwd`
echo "getting files service up"

docker-compose up -d --build --force-recreate
sleep 15
echo "WAITING for service"
curl -vv http://localhost:3082/users

echo "getting files service up"
