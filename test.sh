#!/usr/bin/env bash
set -o errexit

# xtrace turned on only within the travis folds
start() { echo travis_fold':'start:$1; echo $1; set -v; }
end() { set +v; echo travis_fold':'end:$1; echo; echo; }
retry() {
    TRY=1
    until curl --silent --fail http://localhost:$PORT/ > /tmp/response.txt; do
        echo "$TRY: not up yet"
        MAX_TRY=10
        if [ -z "$TRAVIS" ]; then MAX_TRY=3; fi # Fail quick if local
        if (( $TRY > $MAX_TRY )); then
            echo '----------------'
            echo 'docker logs:'
            $OPT_SUDO docker logs $CONTAINER_NAME
            
            echo '----------------'
            # Shiny doesn't follow Docker log idiom:
            # We still need to look at /var/log.
            echo 'cat /var/log/shiny-server/*:'
            docker exec $CONTAINER_NAME sh -c 'ls /var/log/shiny-server; cat /var/log/shiny-server/*'
            
            echo '----------------'
            die "HTTP requests to app never succeeded"
        fi
        (( TRY++ ))
        sleep 1
    done
    echo 'Container responded with:'
    head -n50 /tmp/response.txt
}
source shared.sh


start docker_build
./docker_build.sh
end docker_build


start docker_run
./docker_run.sh
retry
echo "docker is responsive"
ACTUAL_TEXT=`curl http://localhost:$PORT/`
grep 'Hello World!' <(echo "$ACTUAL_TEXT") || die "No match: $ACTUAL_TEXT"

# TODO: uncomment
#docker stop $CONTAINER_NAME
#docker rm $CONTAINER_NAME
#echo "container cleaned up"
end docker_run