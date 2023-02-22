#!/usr/bin/env bash

###### README #################################
###### README #################################
###### README #################################
# after a DSM update a bunch of stuff gets reset at the system level
# the docker binary needs symlink'd into "/usr/bin" so it can be found
# when using docker over ssh without a shell (ie. using docker context, ie. ssh erdos docker
###### README #################################
###### README #################################
###### README #################################

# optional shellcheck options
# shellcheck enable=add-default-case
# shellcheck enable=avoid-nullary-conditions
# shellcheck enable=check-unassigned-uppercase
# shellcheck enable=deprecate-which
# shellcheck enable=quote-safe-variables
# shellcheck enable=require-variable-braces


# IMPORT ENV VARS HERE ##


# ENV SETTINGS ##########
set -e                      # exit all shells if script fails
set -u                      # exit script if uninitialized variable is used
set -o pipefail             # exit script if anything fails in pipe
shopt -s failglob           # fail on regex expansion fail
shopt -s nullglob           # enables recursive globbing
IFS=$'\n\t'


function main(){
  echo "ONLY RUN THIS ON A SYNOLOGY SERVER; REMOVE THE EXIT 1 IN THIS SCRIPT TO ACTUALLY MAKE CHANGES"
  exit 1
  sudo ln -s "$(which docker)" /usr/bin/docker
}
main
