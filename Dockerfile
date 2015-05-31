FROM ubuntu:14.04

MAINTAINER Jacob Henner <code@ventricle.us>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libssl-dev libssl1.0.0 openssl pkg-config git && \
    useradd -u 10000 -d /atheme/ atheme && \
    cd /tmp && \
    git clone https://github.com/atheme/atheme && \
    cd /tmp/atheme && \
    git submodule update --init && \
    ./configure --prefix=/atheme --disable-nls && \
    make && make install && \
    chmod -R 700 /atheme && chown -R atheme /atheme && \ 
    apt-get purge -y build-essential git

VOLUME ["/atheme/etc"]

USER atheme

CMD ["/atheme/bin/atheme-services", "-n"]
