FROM centos:7.8
MAINTAINER “Nguyen Quang Huy” <qhuy199@gmail.com>
ENV container docker
RUN wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm
RUN rpm -Uvh epel-release-7-12.noarch.rpm
RUN yum -y install openvpn easy-rsa net-tools bridge-utils
VOLUME /etc/openvpn
EXPOSE 1194 1195
ENTRYPOINT ["/bin/bash"]
