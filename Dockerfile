FROM node:latest AS node
FROM php:7.4-fpm

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR .

COPY package.json package.json
RUN npm install
RUN apt-get update
RUN apt-get install cowsay -y
RUN apt-get install apache2 -y
#RUN apt-get install php7.4-gd -y
#RUN apt-get install php7.4-mcrypt -y
#RUN apt-get install php7.4-mbstring -y
#RUN apt-get install libapache2-mod-php7 -y
RUN apt-get install mariadb-common mariadb-server mariadb-client -y
RUN a2enmod rewrite
COPY . .
