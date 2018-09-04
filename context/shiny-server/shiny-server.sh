#!/bin/sh
set -e

echo 'environment:'
env # To help with debugging: Did we get the variables we expected?
echo

# Make sure the directory for individual app logs exists
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server

exec shiny-server 2>&1