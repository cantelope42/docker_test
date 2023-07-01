FROM node:latest AS node
FROM php:7.4-fpm

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR .

COPY package.json package.json
RUN npm install
RUN apt install -y cowsay mysql-server apache2 php7.4-gd php7.4-mcrypt php7.4-mbstring libapache2-mod-php7.4
RUN a2enmod rewrite
COPY . .
