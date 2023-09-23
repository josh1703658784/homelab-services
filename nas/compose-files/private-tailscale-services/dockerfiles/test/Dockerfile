
FROM alpine AS install

RUN apk add darkhttpd


FROM tailscale/tailscale:latest AS final

COPY --from=install /usr/bin/darkhttpd /usr/bin/darkhttpd
