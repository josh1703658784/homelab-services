FROM caddy:2.7.4-builder-alpine AS builder

RUN xcaddy build v2.7.4 --with github.com/tailscale/caddy-tailscale

FROM caddy:2.7.4-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
