FROM nginxinc/nginx-unprivileged:stable-alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./uwsgi_params /etc/nginx/uwsgi_params

USER root

RUN mkdir -p /hed/sorage/static
RUN chmod 755 /hed/sorage/static

USER nginx
