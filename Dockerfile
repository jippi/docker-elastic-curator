FROM alpine:3.4

ARG VERSION

RUN apk --update add python py-setuptools py-pip && \
 	pip install elasticsearch-curator==$VERSION && \
  apk del py-pip && \
  rm -rf /var/cache/apk/*
