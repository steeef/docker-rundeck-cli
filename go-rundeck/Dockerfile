FROM golang:alpine
MAINTAINER Stephen Price <stephen@stp5.net>

ENV GOPATH=/go:/src/go-rundeck \
  RUNDECK_URL=http://rundeck:4440 \
  RUNDECK_TOKEN=AFAKETOKENPLEASEREPLACE

RUN apk --update add git tar curl make && \
  mkdir -p /src/go-rundeck && \
  curl -sL https://github.com/lusis/go-rundeck/archive/master.tar.gz | \
    tar -zxf - --strip-components=1 -C /src/go-rundeck && \
  cd /src/go-rundeck && \
  make all && \
  cp bin/* /usr/local/bin/ && \
  cd - && \
  rm -rf /src/go-rundeck && \
  rm -rf /var/cache/apk/*
