FROM jwilder/nginx-proxy:alpine

RUN mkdir -p /etc/nginx/dhparam
                                /etc/nginx/dhparam/dhparam.pem
RUN chown -R nginx:nginx /app /etc/nginx/dhparam/

USER nginx

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
