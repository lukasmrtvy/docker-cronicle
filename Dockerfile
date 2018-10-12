FROM alpine:3.8

ENV VERSION 0.8.28

ENV UID 1337
ENV GID 1337
ENV USER cronicle
ENV GROUP cronicle

RUN   addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP} 

RUN apk update && apk add --no-cache curl npm tzdata procps && \
    mkdir -p /opt/cronicle && curl -sSL https://github.com/jhuckaby/Cronicle/archive/v${VERSION}.tar.gz | tar xz --strip-components=1 -C /opt/cronicle && \
    cd /opt/cronicle && npm install && \
    node bin/build.js dist && \
    chmod -R ${USER}:${GROUP} /opt/cronicle

COPY scripts/entrypoint.sh /
RUN chmod +x entrypoint.sh

WORKDIR /opt/cronicle/bin/

VOLUME     ["/opt/cronicle/data", "/opt/cronicle/logs", "/opt/cronicle/plugins"]

USER cronicle

EXPOSE 3012

ENTRYPOINT ["/entrypoint.sh"]

CMD ["sh","-c","/opt/cronicle/bin/control.sh start"]