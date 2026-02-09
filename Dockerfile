FROM golang:alpine as Tunasync

LABEL maintainer="Jeff"

ENV GO111MODULE on

RUN apk update &&\
        apk add --no-cache ca-certificates gcc musl-dev git make &&\
        git clone https://github.com/tuna/tunasync.git /go/src/github.com/tuna/tunasync

ARG TARGETARCH=amd64
ARG TARGETOS=linux

RUN cd /go/src/github.com/tuna/tunasync && \
    GOARCH=${TARGETARCH} GOOS=${TARGETOS} make && \
    BUILD_FILE=$(find build-* -type f -executable | head -1) && \
    cp ${BUILD_FILE} /build-tunasync && \
    cp ${BUILD_FILE} /build-tunasynctl

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