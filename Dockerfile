FROM golang:alpine as Tunasync

LABEL maintainer="Jeff"
LABEL version="0.9.3"
LABEL description="Tunasync mirror synchronization tool based on v0.9.3"

ENV GO111MODULE=on
ARG TUNASYNC_VERSION=v0.9.3

RUN apk update &&\
        apk add --no-cache ca-certificates gcc musl-dev git make &&\
        git clone --branch ${TUNASYNC_VERSION} --depth 1 https://github.com/tuna/tunasync.git /go/src/github.com/tuna/tunasync

ARG TARGETARCH=amd64
ARG TARGETOS=linux

RUN cd /go/src/github.com/tuna/tunasync && \
    GOARCH=${TARGETARCH} GOOS=${TARGETOS} make && \
    BUILD_DIR=$(find build-* -type d | head -1) && \
    cp ${BUILD_DIR}/tunasync /build-tunasync && \
    cp ${BUILD_DIR}/tunasynctl /build-tunasynctl

FROM alpine:edge

COPY --from=Tunasync /build-tunasync /usr/local/bin/tunasync
COPY --from=Tunasync /build-tunasynctl /usr/local/bin/tunasynctl
COPY run.sh /run.sh

RUN apk --no-cache add curl wget openssh git rsync ca-certificates &&\
        mkdir -p /data/conf /data/mirrors /data/logs &&\
        chmod +x /usr/local/bin/tunasync &&\
        chmod +x /usr/local/bin/tunasynctl &&\
        chmod +x /run.sh
        
COPY conf /data/conf

VOLUME ["/data/conf","/data/mirrors","/data/logs"]

EXPOSE 12345 6000

ENTRYPOINT ["/bin/sh", "-c","/run.sh"]