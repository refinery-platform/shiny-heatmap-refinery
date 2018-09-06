#!/usr/bin/env bash
set -o errexit

source shared.sh

export INPUT_JSON_URL='https://raw.githubusercontent.com/refinery-platform/shiny-heatmap-refinery/0f2125f4ff/context/fixtures/fake-input.json'
echo "INPUT_JSON_URL: $INPUT_JSON_URL"

# "--publish" target needs to match "listen" in shiny-server.conf.
docker run --env INPUT_JSON_URL \
           --name "$CONTAINER_NAME" \
           --detach \
           --publish "$PORT:3838" \
           $IMAGE
echo "Visit http://localhost:$PORT"