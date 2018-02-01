FROM centos:latest

MAINTAINER Leandro Barbosa <leandrobar93@gmail.com>

WORKDIR /build

RUN yum groups mark convert
RUN yum groups mark convert "Development Tools"
RUN yum groupinstall -y "Development Tools"

RUN yum -y install epel-release curl wget git centos-release-scl gcc gcc-c++

RUN wget https://www.openssl.org/source/openssl-1.1.0.tar.gz
RUN tar xzvf openssl-1.1.0.tar.gz && cd openssl-1.1.0 && ./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)' && make && make install
RUN ln -s /usr/local/lib64/libssl.so.1.1 /usr/lib64/
RUN ln -s /usr/local/lib64/libcrypto.so.1.1 /usr/lib64/
RUN ln -s /usr/local/bin/openssl /usr/bin/
RUN wget http://d1h4xl4cr1h0mo.cloudfront.net/v1.9.0/x86_64-unknown-centos-gnu/parity_1.9.0_x86_64.rpm
RUN rpm -i parity_1.9.0_x86_64.rpm
