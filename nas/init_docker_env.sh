#!/usr/bin/env bash

# optional shellcheck options
# shellcheck enable=add-default-case
# shellcheck enable=avoid-nullary-conditions
# shellcheck enable=check-unassigned-uppercase
# shellcheck enable=deprecate-which
# shellcheck enable=quote-safe-variables
# shellcheck enable=require-variable-braces

set -e                      # exit all shells if script fails
set -u                      # exit script if uninitialized variable is used
set -o pipefail             # exit script if anything fails in pipe

function main(){
  docker context use NAS_INTERNAL
  docker context list

  # https://github.com/lucaslorentz/caddy-docker-proxy#basic-usage-example-using-docker-compose
  # this network must be created external to the docker-compose file
  docker network create caddy
}
main
