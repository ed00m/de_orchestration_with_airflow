#!/usr/bin/env bash

# https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html
 
# Airflow needs a home. `~/airflow_running_with_docker` is the default, but you can put it
# somewhere else if you prefer (optional)
export AIRFLOW_HOME=~/airflow_running_with_docker

# Setting the right Airflow user
# On Linux, the quick-start needs to know your host user id and needs to have group id set to 0.
# Otherwise the files created in dags, logs and plugins will be created with root user.
# You have to make sure to configure them for the docker-compose:

mkdir -p ${AIRFLOW_HOME}/dags ${AIRFLOW_HOME}/logs ${AIRFLOW_HOME}/plugins

# In case of running manually
echo "AIRFLOW_UID=$(id -u)" > ${AIRFLOW_HOME}/.env
echo $(cat ${AIRFLOW_HOME}/.env)

# if YAML does not exist download
if [ ! -f ${AIRFLOW_HOME}/docker-compose.yaml ]; then
    curl -o ${AIRFLOW_HOME}/docker-compose.yaml \
        -Lfs 'https://airflow.apache.org/docs/apache-airflow/2.3.3/docker-compose.yaml'
else
    echo "YAML exists ${AIRFLOW_HOME}/docker-compose.yaml does not download"
fi

# Check Docker / Docker Compose
EXISTS_BINARY_DOCKER_COMPOSE=$(whereis -b docker-compose |awk '{print $2}')
EXISTS_BINARY_DOCKER=$(whereis -b docker |awk '{print $2}')

# if binary exists running with docker
if [ ! -z ${EXISTS_BINARY_DOCKER_COMPOSE} ] && [ ! -z ${EXISTS_BINARY_DOCKER} ]; then
    echo "MEMORY: "$(docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))')

    export COMPOSE_FILE=${AIRFLOW_HOME}/docker-compose.yaml
    export AIRFLOW_UID=$(id -u)

    # airflow init
    docker-compose up airflow-init >> ${AIRFLOW_HOME}/logs/airflow-init_$(date +"%Y-%m-%d").log
    echo "[X] check airflow-init log in "${AIRFLOW_HOME}/logs/airflow-init_$(date +"%Y-%m-%d").log

    # shell args
    if [ $# -gt 0 ]; then
        #
        # https://airflow.apache.org/docs/apache-airflow/stable/usage-cli.html
        #
        # Now you can run commands easier.

        # ./running.sh info
        # You can also use bash as parameter to enter interactive bash shell in the container or python
        # to enter python container.

        # ./running.sh bash
        # ./running.sh python

        exec docker-compose run --rm airflow-cli "${@}"
    else
        exec docker-compose up
    fi
else
    echo "
docker and docker-compose binary not found,

Install with

https://docs.docker.com/engine/install/
https://docs.docker.com/desktop/install/linux-install/
    "
fi  
