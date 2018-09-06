#!/bin/sh

# Shiny server scrubs environment variables on startup...
# https://groups.google.com/forum/#!topic/shiny-discuss/nNs0kztwdWo
# ... so instead we need to write this to a place where it can be read.

INPUT_PATH=/tmp/input.json
wget -O $INPUT_PATH $INPUT_JSON_URL || echo $INPUT_JSON > $INPUT_PATH

# Everything below is copy-and-paste from the original:
# -----------------------------------------------------

# Make sure the directory for individual app logs exists
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server

if [ "$APPLICATION_LOGS_TO_STDOUT" = "false" ];
then
    exec shiny-server 2>&1
else
    # start shiny server in detached mode
    exec shiny-server 2>&1 &

    # push the "real" application logs to stdout with xtail
    exec xtail /var/log/shiny-server/
fi