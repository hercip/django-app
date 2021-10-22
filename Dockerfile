FROM python:3.9-alpine
LABEL maintainer="cip@ibit.ro"
ENV PATH="/scripts:${PATH}"
COPY ./requirements.txt /requirements.txt
COPY ./scripts /scripts
RUN \
  apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers postgresql-dev gcc python3-dev musl-dev g++ && \
  python -m pip install --upgrade pip && pip install -r /requirements.txt && \
  apk del .tmp && \
  apk add --no-cache py3-psycopg2 py3-numpy py3-pandas && \
  mkdir /code  && \
  mkdir -p /app/sorage/web/media  && \
  mkdir -p /app/sorage/web/static && \
  adduser -D user && \
  chown -R user:user /app/sorage && \
  chmod -R 755 /app/sorage/web  && \
  chmod +x /scripts/*
COPY ./code /code
WORKDIR /code
USER user
CMD ["entrypoint.sh"]
