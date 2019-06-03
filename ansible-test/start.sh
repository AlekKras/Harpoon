#!/bin/bash

pull(){
    docker pull grafana/grafana
    docker pull hashicorp/terraform
}

check_grafana(){
    docker run --env rl_args="report=detail"  -it --rm --user 0 --entrypoint "/bin/sh" grafana/grafana -c '(apt-get update && apt-get install curl -y) || (apk update && apk add curl) || (yum install curl -y );SCAN_CMD=$(eval "curl -s https://vscanapidoc.redlock.io/scan.sh") && echo "$SCAN_CMD" | sh'
}

check_terraform(){
    docker run --env rl_args="report=detail"  -it --rm --user 0 --entrypoint "/bin/sh" hashicorp/terraform -c '(apt-get update && apt-get install curl -y) || (apk update && apk add curl) || (yum install curl -y );SCAN_CMD=$(eval "curl -s https://vscanapidoc.redlock.io/scan.sh") && echo "$SCAN_CMD" | sh'
}


if [[ $(which docker) && $(docker --version) ]]; then
    echo "Proceed"
    echo ". . . " 
    sleep 3
    echo ". . . "
    echo "Pulling Docker images"
    sleep 3
    pull
    echo "Checking Grafana"
    sleep 3
    check_grafana
    echo "Checking Terraform"
    sleep 3
    check_terraform

  else
    echo "Install docker"
    # command
fi