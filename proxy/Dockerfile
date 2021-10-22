FROM nginxinc/nginx-unprivileged:stable-alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./uwsgi_params /etc/nginx/uwsgi_params

USER root

RUN mkdir -p /app/sorage/static
RUN chmod 755 /app/sorage/static

USER nginx
