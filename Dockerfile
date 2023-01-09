FROM ubuntu:latest

LABEL maintainer="OEAW ACDH-CH - Klaus Illmayer <klaus.illmayer@oeaw.ac.at>"
LABEL description="Having a simple webserver with download links for the vocabularies"

ENV DEBIAN_FRONTEND=noninteractive

# based on docker-tools-environment http and base_http_php Dockerfile created by Mateusz Żółtak (OEAW ACDH-CH)
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y supervisor apache2 apache2-utils libapache2-mpm-itk links curl vim locales && \
  apt clean && \
  rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  a2enmod rewrite && \
  a2enmod headers && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  sed -i -e 's/StartServers.*/StartServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf && \
  sed -i -e 's/MinSpareServers.*/MinSpareServers 1/g' /etc/apache2/mods-enabled/mpm_prefork.conf

# set up utf-8 locale (defaults in offical centos/ubuntu images are POSIX)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:ean

# configure
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# expose
CMD ["/usr/bin/supervisord"]
EXPOSE 80

