#! /bin/bash

set -e

. ./set-env-postgres.sh

docker-compose -f docker-compose-postgres.yml down -v

docker-compose -f docker-compose-postgres.yml up -d --build zookeeper postgres kafka

./wait-for-postgres.sh

docker-compose -f docker-compose-postgres.yml up -d --build

./gradlew :end-to-end-tests:cleanTest
./gradlew build

docker-compose -f docker-compose-postgres.yml down -v
