FROM alpine:3.10

ENV VERSION 0.8.32

ENV UID 1337
ENV GID 1337
ENV USER cronicle
ENV GROUP cronicle

COPY scripts/entrypoint.sh /

RUN set -xe && \
    addgroup -S $GROUP -g $GID && adduser -D -S -u $UID $USER $GROUP && \
    apk update && apk add --no-cache tini curl npm tzdata procps && \
    mkdir -p /opt/cronicle && curl -sSL https://github.com/jhuckaby/Cronicle/archive/v${VERSION}.tar.gz | tar xz --strip-components=1 -C /opt/cronicle && \
    cd /opt/cronicle && npm install && \
    node bin/build.js dist && \
    mkdir -p /opt/cronicle/data  /opt/cronicle/logs /opt/cronicle/plugins && chown -R $USER:$GROUP /opt/cronicle && \
    chmod +x entrypoint.sh

WORKDIR /opt/cronicle/bin/

VOLUME ["/opt/cronicle/data", "/opt/cronicle/logs", "/opt/cronicle/plugins"]

USER cronicle

EXPOSE 3012

ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]

CMD ["sh","-c","/opt/cronicle/bin/control.sh start"]
