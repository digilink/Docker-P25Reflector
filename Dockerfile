#!/bin/bash

FROM debian:stretch
MAINTAINER Stephen Brown - K1LNX "k1lnx@k1lnx.net"

WORKDIR /
ENV HOME /

RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install libstdc++6 -y
RUN apt-get install lighttpd -y
RUN apt-get install php7.0-cgi -y
RUN apt-get install nano -y

COPY P25Reflector /P25Reflector
COPY P25Reflector.ini /etc/P25Reflector.ini
COPY DMRIds.dat /DMRIds.dat
COPY entry.sh /entry.sh
COPY P25Reflector-Dashboard* /var/www/html 

RUN chmod +x /P25Reflector
RUN chmod +x /entry.sh
RUN chmod +x /etc/P25Reflector.ini
RUN chmod +x /DMRIds.dat
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html
RUN lighty-enable-mod fastcgi
RUN lighty-enable-mod fastcgi-php

EXPOSE 80/tcp
EXPOSE 41000/udp
ENTRYPOINT ["/entry.sh"]
