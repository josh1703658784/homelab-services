#!/usr/bin/env bash


# optional shellcheck options
# shellcheck enable=add-default-case
# shellcheck enable=avoid-nullary-conditions
# shellcheck enable=check-unassigned-uppercase
# shellcheck enable=deprecate-which
# shellcheck enable=quote-safe-variables
# shellcheck enable=require-variable-braces


# ENV SETTINGS ##########
set -e                      # exit all shells if script fails
set -u                      # exit script if uninitialized variable is used
set -o pipefail             # exit script if anything fails in pipe
shopt -s failglob           # fail on regex expansion fail
shopt -s nullglob           # enables recursive globbing
IFS=$'\n\t'


# MAIN ##################
function main(){

  local -r src='/readonly_mullvad_us_nyc.ovpn'
  local -r dest='/etc/openvpn/custom/mullvad_us_nyc.ovpn'
  local -r dest_dirpath="$( dirname "${dest}" )"
    
  mkdir -p "${dest_dirpath}"
  cp "${src}" "${dest}"
  chmod 666 "${dest}"

  exit 0
}
main

