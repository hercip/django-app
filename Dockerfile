FROM python:3.9-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /code
COPY ./code /code
WORKDIR /code
COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /hed/sorage/web/media
RUN mkdir -p /hed/sorage/web/static
RUN adduser -D user
RUN chown -R user:user /hed/sorage
RUN chmod -R 755 /hed/sorage/web
USER user

CMD ["entrypoint.sh"]
