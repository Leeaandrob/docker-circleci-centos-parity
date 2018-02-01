FROM centos:latest

MAINTAINER Leandro Barbosa <leandrobar93@gmail.com>

RUN yum groups mark convert
RUN yum groups mark convert "Development Tools"
RUN yum groupinstall -y "Development Tools"

RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install curl wget git gcc gcc-c++

RUN wget https://www.openssl.org/source/openssl-1.1.0.tar.gz
RUN tar xzvf openssl-1.1.0.tar.gz && cd openssl-1.1.0 && ./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)' && make && make install
RUN ln -s /usr/local/lib64/libssl.so.1.1 /usr/lib64/
RUN ln -s /usr/local/lib64/libcrypto.so.1.1 /usr/lib64/
RUN rm /usr/bin/openssl
RUN ln -s /usr/local/bin/openssl /usr/bin/
RUN openssl version
RUN bash <(curl https://get.parity.io -Lk)
