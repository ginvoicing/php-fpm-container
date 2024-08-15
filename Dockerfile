FROM php:8.1-fpm-bookworm
ENV DEBIAN_FRONTEND noninteractive
LABEL maintainer="Tarun Jangra<tarun.jangra@hotmail.com>"

RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libicu-dev \
    libxcb1 \
    libxext6 \
    libxrender1 \
    libc6 \
    libfreetype6 \
    libcurl4-gnutls-dev \
    libzip-dev \
    libxml2-dev \
    libyaml-dev \
    libtidy-dev \
    libldb-dev \
    libldap2-dev \
    libc-client-dev \
    libkrb5-dev \
    unzip \
    fontconfig \
    xfonts-75dpi \
    xfonts-base \
    curl \
    fonts-lohit-guru \
    fonts-guru-extra \
    fonts-guru \
    libgmp-dev \
    unzip \
    python3


RUN docker-php-ext-configure gd \
    --with-webp \
    --with-jpeg \
    --with-xpm \
    --with-freetype \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-install fileinfo \
    && docker-php-ext-install curl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gmp \
    && docker-php-ext-install opcache

RUN docker-php-ext-configure imap \
    --with-kerberos \
    --with-imap-ssl \
    && docker-php-ext-install imap

ADD https://getcomposer.org/download/latest-2.x/composer.phar /usr/local/bin/

RUN chmod +x /usr/local/bin/composer.phar

RUN apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /bin/sh && ln -s /bin/bash /bin/sh
