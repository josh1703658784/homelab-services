#!/usr/bin/env bash


# optional shellcheck options
# shellcheck enable=add-default-case
# shellcheck enable=avoid-nullary-conditions
# shellcheck enable=check-unassigned-uppercase
# shellcheck enable=deprecate-which
# shellcheck enable=quote-safe-variables
# shellcheck enable=require-variable-braces

source .env

# IMPORT ENV VARS HERE ##
readonly CADDY_DATA="${CADDY_DATA}"



# ENV SETTINGS ##########
set -e                      # exit all shells if script fails
set -u                      # exit script if uninitialized variable is used
set -o pipefail             # exit script if anything fails in pipe
shopt -s failglob           # fail on regex expansion fail
shopt -s nullglob           # enables recursive globbing
IFS=$'\n\t'



# GLOBALS ###############

#########################
# UTILITY FUNCTIONS  ####
#########################
function get_script_dirpath(){
  cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
}

function require(){ 
  hash "${@}" || exit 127; 
}

function set_functions_readonly(){
  local -r all_functions="$( declare -F | sed 's/declare -f //g' )"
  for function in ${all_functions}; do
    readonly -f "${function}"
  done
}


function verify_dependencies(){
  local -ra dependencies=(
    # list all binary dependencies here
    source
    scp
  )

  # shellcheck disable=SC2068
  for dependency in ${dependencies[@]}; do
    require "${dependency}"
  done
}


function initialize(){
  set_functions_readonly
  verify_dependencies
}


# MAIN ##################
function main(){
    initialize

    local -r server_ip='10.0.0.11'
    local -r script_dirpath="$(get_script_dirpath)"

    echo "scp "${script_dirpath}/configs/caddy/Caddyfile" "${server_ip}":"${CADDY_DATA}/etc/caddy/Caddyfile""
    scp "${script_dirpath}/configs/caddy/Caddyfile" "${server_ip}":"${CADDY_DATA}/etc/caddy/Caddyfile"
    
    exit 0
}
main

