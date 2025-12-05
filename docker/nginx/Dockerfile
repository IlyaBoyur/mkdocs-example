FROM nginx:stable-alpine

RUN apk upgrade && \
    apk add --no-cache esh curl openssl && \
    rm /etc/nginx/conf.d/default.conf

COPY nginx.conf.esh ssl_params /etc/nginx/

WORKDIR /app

COPY entrypoint.sh .

RUN chown -R nginx:nginx /app && \
    chmod -R 755 /app && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /etc/nginx

USER nginx
RUN curl https://get.acme.sh | sh 

USER root
RUN chmod +x /app/entrypoint.sh && \
    ln -sf /var/cache/nginx/.acme.sh/acme.sh /usr/local/bin/acme.sh && \ 
    chmod +x /usr/local/bin/acme.sh

ARG ENVIRONMENT \
    HTPASSWD_NODE \
    HTPASSWD \
    TLS_MODE \
    SITE_HOST

ENV ENVIRONMENT=development \
    HTPASSWD_NODE=off \
    HTPASSWD=to_be_defined \
    TLS_MODE=off \
    SITE_HOST=localhost

EXPOSE 80/tcp 443/tcp

CMD ["/bin/sh", "/app/entrypoint.sh"]