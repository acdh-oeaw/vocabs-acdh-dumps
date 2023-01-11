FROM ubuntu:latest

LABEL maintainer="OEAW ACDH-CH - Klaus Illmayer <klaus.illmayer@oeaw.ac.at>"
LABEL description="Having a simple webserver with download links for the vocabularies"

ARG DEBIAN_FRONTEND=noninteractive

# based on docker-tools-environment http and base_http_php Dockerfile created by Mateusz Żółtak (OEAW ACDH-CH)
RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y apache2 apache2-utils links curl vim git locales unzip && \
  apt-get clean

RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/Europe/Vienna /etc/localtime

COPY dockerfiles/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite && \
  a2enmod expires

WORKDIR /var/www/html
RUN rm index.html

# put downloads into html
COPY . /var/www/html

# expose and start server
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
