# Centos 7 with golang 1.6 installed

FROM centos:7
MAINTAINER stwigger@gmail.com

ENV GOROOT /usr/local/go
ENV GOBIN $GOROOT/bin 

RUN yum update -y
RUN yum install -y gcc
RUN yum install -y wget 
RUN yum install -y git 

ENV GOLANG_VERSION 1.6.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_ARCHIVE go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a

RUN wget $GOLANG_DOWNLOAD_URL \
	&& echo "$GOLANG_DOWNLOAD_SHA256 $GOLANG_ARCHIVE" | sha256sum -c - \
	&& tar -C /usr/local -xzf $GOLANG_ARCHIVE \
	&& rm $GOLANG_ARCHIVE


ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/

# RUN $GOBIN/go version
# RUN gcc -v
