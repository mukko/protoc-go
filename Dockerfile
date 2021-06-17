FROM golang:latest

RUN apt-get update &&  \
    apt-get install -y \
    git \
    make \
    autoconf \
    automake \
    libtool \
    unzip \
    curl \
    g++

RUN mkdir -p /src
WORKDIR /src
ENV VERSION v3.17.2
RUN git clone https://github.com/protocolbuffers/protobuf

WORKDIR /src/protobuf
RUN git checkout ${VERSION}

RUN git submodule update --init --recursive
RUN ./autogen.sh && ./configure --prefix=/usr
RUN make -j 3
RUN make check install

WORKDIR /src
RUN rm -rf protobuf

RUN go get -u github.com/golang/protobuf/protoc-gen-go \
              github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
              github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

RUN apt-get purge -y \
    git \
    make \
    autoconf \
    automake \
    libtool \
    unzip \
    curl \
    g++ &&\
    apt-get clean -y

ENTRYPOINT [ "protoc" ]