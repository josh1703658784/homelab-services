#!/bin/sh

docker run --rm -it -v "/volume1/docker-data/services/plex-meta-manager/app-data/config:/config:rw" meisnate12/plex-meta-manager --run
