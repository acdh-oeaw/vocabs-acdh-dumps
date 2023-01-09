FROM ubuntu:latest

LABEL maintainer="OEAW ACDH-CH - Klaus Illmayer <klaus.illmayer@oeaw.ac.at>"
LABEL description="Having a simple webserver with download links for the vocabularies"

ENV DEBIAN_FRONTEND=noninteractive

# based on docker-tools-environment http and base_http_php Dockerfile created by Mateusz Żółtak (OEAW ACDH-CH)
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y apache2 apache2-utils links curl vim git locales && \
  apt clean && \
  rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  a2enmod rewrite

# expose
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]
