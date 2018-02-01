FROM centos:latest

MAINTAINER Leandro Barbosa <leandrobar93@gmail.com>

RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install curl wget git gcc gcc-c++

RUN wget https://www.openssl.org/source/openssl-1.1.0.tar.gz
RUN tar xzvf openssl-1.1.0.tar.gz && cd openssl-1.1.0 && ./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)' && make && sudo make install
RUN sudo ln -s /usr/local/lib64/libssl.so.1.1 /usr/lib64/
RUN sudo ln -s /usr/local/lib64/libcrypto.so.1.1 /usr/lib64/
RUN sudo rm /usr/bin/openssl
RUN sudo ln -s /usr/local/bin/openssl /usr/bin/
RUN openssl version
