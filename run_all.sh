#!/bin/env bash

echo "exporting needed environment variables"
source .env
BASE_PWD=`pwd`
echo "getting files service up"
cd ${BASE_PWD}/devops-test-app-files

docker-compose up -d --build --force-recreate
curl -vv http://localhost:3081/files

echo "getting files service up"

cd ${BASE_PWD}/devops-test-app-users
docker-compose up -d --build --force-recreate
curl -vv http://localhost:3082/users

