FROM golang:alpine as goBuilder

LABEL maintainer="Jeff https://github.com/jeffok"

ENV GO111MODULE on

RUN apk update &&\
        apk add --no-cache ca-certificates gcc musl-dev git make &&\
        go get -v -d github.com/tuna/tunasync/cmd/tunasync ;\
        git clone https://github.com/tuna/tunasync.git /go/src/github.com/tuna/tunasync

RUN cd /go/src/github.com/tuna/tunasync && make 

FROM alpine:edge

RUN apk --no-cache add bash curl wget openssh git rsync ca-certificates ;\
        mkdir -p /etc/tunasync /mirrors /var/log/tunasync ;\
        git clone https://github.com/tuna/tunasync-scripts/ /mirrors/scripts

RUN addgroup --gid 2001 mirrorgroup ;\
    adduser --disabled-password --uid 2001 mirrors mirrorgroup ;\
    chown -R mirrors:mirrorgroup /mirrors ;\
    chmod 775 /mirrors

COPY --from=goBuilder /go/src/github.com/tuna/tunasync/build-linux-amd64 /usr/local/bin
COPY conf /etc/tunasync

VOLUME ["/etc/tunasync","/mirrors","/var/log/tunasync"]

EXPOSE 12345 6000

USER mirrors

ENTRYPOINT ["/bin/bash", "-c", "(tunasync manager --config /etc/tunasync/manager.conf &); (tunasync worker --config /etc/tunasync/workers.conf)"]