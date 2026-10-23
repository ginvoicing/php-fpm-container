FROM php:8.5-fpm-trixie
ENV DEBIAN_FRONTEND=noninteractive
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
    python3

RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mysqli \
        intl \
        pdo_mysql \
        zip \
        fileinfo \
        curl \
        bcmath \
        gmp

RUN apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
