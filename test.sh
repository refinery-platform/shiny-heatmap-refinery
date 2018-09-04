#!/usr/bin/env bash
set -o errexit

# xtrace turned on only within the travis folds
start() { echo travis_fold':'start:$1; echo $1; set -v; }
end() { set +v; echo travis_fold':'end:$1; echo; echo; }
retry() {
    TRIES=1
    until curl --silent --fail http://localhost:$PORT/ > /tmp/response.txt; do
        echo "$TRIES: not up yet"
        if (( $TRIES > 10 )); then
            echo '----------------'
            echo 'docker logs:'
            $OPT_SUDO docker logs $CONTAINER_NAME
            
            echo '----------------'
            # Shiny doesn't follow Docker logger idiom:
            # We still need to look at /var/log.
            echo 'docker exec cat:'
            docker exec $CONTAINER_NAME sh -c 'cat /var/log/shiny-server/*'
            
            echo '----------------'
            die "HTTP requests to app never succeeded"
        fi
        (( TRIES++ ))
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
ACTUAL_TEXT=`curl http://localhost:8888/`
grep 'TODO: heatmap ... ???' <(echo "$ACTUAL_TEXT") || die "No match: $ACTUAL_TEXT"

docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
echo "container cleaned up"
end docker_run