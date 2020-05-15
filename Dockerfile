FROM oraclelinux:7.7

RUN yum -y install wget && \
    wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm && \
    rpm -Uvh epel-release-7-12.noarch.rpm && \
    yum -y install openvpn easy-rsa net-tools bridge-utils && \
    wget -O /tmp/easyrsa https://github.com/OpenVPN/easy-rsa-old/archive/2.3.3.tar.gz && \
    tar xfz /tmp/easyrsa && \
    mkdir -p /etc/openvpn/easy-rsa && \
	cp -rf easy-rsa-old-2.3.3/easy-rsa/2.0/* /etc/openvpn/easy-rsa
WORKDIR /etc/openvpn/
ADD	server.conf ./
RUN mkdir /etc/openvpn/easy-rsa/keys/ && \
    cd /etc/openvpn/easy-rsa && \
	source ./vars && \
	./clean-all && \
	./build-ca && \
	./build-key-server server && \
	./build-dh
RUN cd /etc/openvpn/easy-rsa/keys && \
    cp dh2048.pem ca.crt server.crt server.key /etc/openvpn/ && \
	cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf
	
RUN useradd -M -s /bin/false vpnuser1 && \
    passwd vpnuser1
