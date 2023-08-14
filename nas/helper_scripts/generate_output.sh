#!/usr/bin/env bash


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




declare -r RESULTS_OUTPUT="${HOME}/Documents/Developer/Repositories/synology/home-server-docker/servers.txt"
declare -r WORKING_DIR="${HOME}/Documents/Developer/Repositories/synology/home-server-docker"
declare -r TRUE='true'
declare -r FALSE='false'
declare -ri GOOD_RETURN_CODE='0'


function checker(){
  local -r message="$( docker exec -it movies bash -c 'curl https://am.i.mullvad.net/connected' )"
  local -r is_exit="${1}"

  if [[ "${is_exit}" == "${TRUE}" ]]; then
    echo '<<<<<<<< SUCCESS! EXITING FUNCTION >>>>>>>>>>>.'
    return
  fi

  local -ri result="$( echo "${message}" | grep -q 'You are connected'; echo "${?}" )"

  if [[ "${result}" == "${GOOD_RETURN_CODE}" ]]; then 
    echo "$(date +%s) ${message}" >> "${RESULTS_OUTPUT}"
    checker "${TRUE}"
  else
    echo "${message}"
    sleep 2
    echo "<<<<< FAILURE, RE-CHECKING >>>>>"
    checker "${FALSE}"
  fi
}


function restart_container(){
  cd "${WORKING_DIR}"
  docker rm -f movies
  docker-compose up -d movies
}


function run(){
  restart_container
  checker "${FALSE}"
}


function main(){
  for i in {1..20}; do   
    run
  done
  say "THIS SCRIPT IS COMPLETE"
}
main

