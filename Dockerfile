FROM ubuntu:14.04

MAINTAINER Jacob Henner <code@ventricle.us>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libssl-dev libssl1.0.0 openssl pkg-config git
RUN useradd -u 10000 -d /xtheme/ xtheme && \
    cd /tmp && \
    git clone https://github.com/XthemeOrg/Xtheme && \
    cd /tmp/Xtheme && \
    git checkout tags/7.3.5 && \
    git submodule update --init && \
    ./configure --prefix=/xtheme --disable-nls && \
    make && make install && \
    chmod -R 700 /xtheme && chown -R xtheme /xtheme
RUN apt-get purge -y build-essential git && apt-get autoremove -y

VOLUME ["/xtheme/etc"]

USER xtheme

CMD ["/xtheme/bin/xtheme-services", "-n"]
