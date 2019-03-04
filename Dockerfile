FROM node:8-alpine
LABEL maintainer="requarks.io"

RUN apk update && \
    apk add bash curl git openssh supervisor python2 make g++ --no-cache && \
    mkdir -p /var/wiki && \
    mkdir -p /logs

COPY . /var/wiki
WORKDIR /var/wiki

RUN npm install
RUN yarn run build

#COPY supervisord.conf /etc/supervisord.conf


#ENV WIKI_JS_HEROKU=1

ADD config.yml config.yml

EXPOSE 3000
EXPOSE 80
ENTRYPOINT [ "node", "server" ]
