FROM nginx:stable-alpine

RUN apk upgrade && \
    apk add --no-cache esh curl openssl && \
    rm /etc/nginx/conf.d/default.conf

COPY nginx.conf.esh /etc/nginx/

WORKDIR /app

COPY entrypoint.sh .

RUN chmod +x /app/entrypoint.sh

ENV HTPASSWD_NODE=off \
    HTPASSWD=override_if_needed

EXPOSE 80/tcp 443/tcp

CMD ["/bin/sh", "/app/entrypoint.sh"]