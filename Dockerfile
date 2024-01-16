FROM golang:1.21-alpine
LABEL maintainer="Jay's <https://github.com/hermesdj/go-evepraisal>"
WORKDIR $GOPATH/src/github.com/hermesdj/go-evepraisal

COPY . .

RUN apk --update add --no-cache --virtual build-dependencies git gcc musl-dev make bash && \
    export GO111MODULE=on ENV=prod && \
    make setup && \
    make build && \
    make install && \
    mkdir /evepraisal/ && \
    mv $GOPATH/bin/evepraisal /evepraisal/evepraisal && \
    rm -rf $GOPATH && \
    apk del build-dependencies && \
    mkdir /evepraisal/db
WORKDIR /evepraisal/

EXPOSE 8080
EXPOSE 8081

CMD ["./evepraisal"]
