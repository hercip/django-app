FROM python:3.9-alpine
LABEL maintainer="cip@ibit.ro"
ENV PATH="/scripts:${PATH}"


# RUN \
#   apt-get update && \
#   apt-get install -y sudo curl git-core gnupg locales zsh \
#   wget fonts-powerline && \
#   locale-gen en_US.UTF-8
# ENV DEBIAN_FRONTEND=dialog
# RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && /usr/sbin/locale-gen
# ENV SHELL /bin/zsh
# ADD . ${CODE_LOCATION}/
# RUN \
#   wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
#   git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && \
#   cd $HOME && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower &&\
#   pip install -r ${CODE_LOCATION}/code/requirements.dev.txt
# ADD .devcontainer/.* /root/

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
ENTRYPOINT ["entrypoint.sh"]
# ENTRYPOINT ["./entrypoint.sh"]
# CMD ["python", "./manage.py", "runserver", "0.0.0.0:8000"]