image=$1
docker run --env rl_args="report=detail"  -it --rm --user 0 --entrypoint "/bin/sh" $image -c '(apt-get update && apt-get install curl -y) || (apk update && apk add curl) || (yum install curl -y );SCAN_CMD=$(eval "curl -s https://vscanapidoc.redlock.io/scan.sh") && echo "$SCAN_CMD" | sh'