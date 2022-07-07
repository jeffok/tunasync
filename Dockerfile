FROM golang:alpine as Tunasync

LABEL maintainer="Jeff"

ENV GO111MODULE on

RUN apk update &&\
        apk add --no-cache ca-certificates gcc musl-dev git make &&\
        go get -v -d github.com/tuna/tunasync/cmd/tunasync ;\
        git clone https://github.com/tuna/tunasync.git /go/src/github.com/tuna/tunasync

RUN cd /go/src/github.com/tuna/tunasync && make 

FROM alpine:edge

COPY --from=Tunasync /go/src/github.com/tuna/tunasync/build-linux-amd64 /usr/local/bin
COPY run.sh /run.sh

RUN apk --no-cache add curl wget openssh git rsync ca-certificates &&\
        mkdir -p /data/conf /data/mirrors /data/logs ;\
        chmod +x /usr/local/bin/tunasync ;\
        chmod +x /usr/local/bin/tunasynctl ;\
        chmod +x /run.sh
        
COPY conf /data/conf

VOLUME ["/data/conf","/data/mirrors","/data/logs"]

EXPOSE 12345 6000

ENTRYPOINT ["/bin/sh", "-c","/run.sh"]