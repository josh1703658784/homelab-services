#!/bin/bash

servers=(
us-nyc-217.mullvad.net
us-nyc-201.mullvad.net
us-nyc-212.mullvad.net
us-nyc-202.mullvad.net
us-nyc-208.mullvad.net
us-nyc-204.mullvad.net
us-nyc-101.mullvad.net
us-nyc-211.mullvad.net
us-nyc-215.mullvad.net
us-nyc-216.mullvad.net
us-nyc-102.mullvad.net
us-nyc-213.mullvad.net
us-nyc-218.mullvad.net
us-nyc-203.mullvad.net
us-nyc-206.mullvad.net
us-nyc-205.mullvad.net
us-nyc-214.mullvad.net
us-nyc-207.mullvad.net
us-nyc-209.mullvad.net
)

for server in ${servers[@]}; do
  ip_address="$( dig "${server}" +short )"

  read  -n 1 -p "Press any key to continue" ___
  echo "COPYING SERVER CLIPBOARD: ${server}"
  echo "${server}" | pbcopy

  read  -n 1 -p "Press any key to continue" ___
  echo "COPYING IP TO CLIPBPARD: ${ip_address}"
  echo "${ip_address}" | pbcopy

  read  -n 1 -p "Press any key to continue" ___
  echo 'COPYING PROVIDER TO CLIPBOARD: mullvad.net'
  echo 'mullvad.net' | pbcopy
done
