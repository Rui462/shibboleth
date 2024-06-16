FROM php:8.1.0-apache

RUN apt-get update && apt-get install -y libapache2-mod-shib && apt-get clean

COPY apache2/shib2.conf /etc/apache2/sites-available/shib2.conf
COPY .docker/*.xml /etc/shibboleth/
COPY .docker/*.pem /etc/shibboleth/
COPY .docker/*.key /etc/shibboleth/
COPY .docker/*.crt /etc/shibboleth/
COPY src/ /var/www/html

RUN service apache2 restart
RUN a2enmod ssl rewrite proxy_http headers
RUN a2ensite shib2
RUN a2dissite 000-default.conf