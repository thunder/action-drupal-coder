FROM composer:2 AS composer
FROM php:8.1-cli-alpine

ENV REVIEWDOG_VERSION=v0.14.2

ENV COMPOSER_ALLOW_SUPERUSER=1

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV PATH="${PATH}:/root/.composer/vendor/bin"

# Install phpcs and set the code sniffer path
RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true; \
    composer global require drupal/coder;

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
