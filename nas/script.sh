
readonly REMOVE_ME="$(docker volume ls | grep 'local     caddy_tailscale-sidecar\|local     nas_' | awk '{{ print $2 }}' )"


for name in ${REMOVE_ME}; do
  docker volume rm "${name}"
done
