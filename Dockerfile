FROM composer:1 AS composer
FROM php:7.4-cli-alpine

ENV REVIEWDOG_VERSION=v0.13.0

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV PATH="${PATH}:/root/.composer/vendor/bin"

# Install phpcs and set the code sniffer path
RUN composer global require drupal/coder && \
    phpcs --config-set installed_paths /root/.composer/vendor/drupal/coder/coder_sniffer/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
