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


function get_script_dirpath(){
  cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
}


function sanitize_input(){
  # shellcheck disable=SC2002
  # uuoc snytax is sometimes visually easier to read imo
  cat servers.txt | sort | uniq
}


function parse_out_hostname_ip(){
  local -r sanitized_text="${1}"
  # shellcheck disable=SC2001
  echo "${sanitized_text}" \
    | sed 's/You are connected to Mullvad (server \(ch-zrh-[0-9][0-9][0-9]\)). Your IP address is/\1/g'
}


function manipulate_and_format_csv(){
  local -r server_ip="${1}"
  echo "${server_ip}" | sed 's/ /_/g' | sed 's/\(ch-zrh-[0-9]*_\([0-9\.]*\)\)/\1,\2/g'
}


function manipulate_input_to_csv(){
  local -r sanitized_text="$(sanitize_input)"
  local -r server_ip="$( parse_out_hostname_ip "${sanitized_text}" )"
  local -r csv="$( manipulate_and_format_csv "${server_ip}" )"
  echo "${csv}"

}


function keypress_prompt(){
  local -r data="${1}"
  read -rn 1 -p "Press any key to continue" ___
  echo "COPYING SERVER CLIPBOARD: ${data}"
  echo "${data}" | pbcopy
}


function copy_paste_interactive(){
  local -r server_info="${1}"
  local -r server_name="$( echo "${server_info}" | cut -d',' -f1 )"
  local -r ip_address="$(  echo "${server_info}" | cut -d',' -f2 )"

  keypress_prompt "${server_name}"
  keypress_prompt "${ip_address}"
}


function set_functions_readonly(){
  local -r all_functions="$( declare -F | sed 's/declare -f //g' )"
  for function in ${all_functions}; do
    readonly -f "${function}"
  done
}


function main(){ 
  set_functions_readonly
  #local -r input_filename='servers.txt'
  #local -r input_filepath="$( get_script_dirpath )/${input_filename}"
  local -r csv="$( manipulate_input_to_csv )"

  for row in ${csv}; do
    copy_paste_interactive "${row}"
  done

}
main
