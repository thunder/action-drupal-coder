FROM composer:1.9.1 AS composer-build
FROM php:7.4-cli-alpine3.11

ENV REVIEWDOG_VERSION=v0.9.17

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY --from=composer-build /usr/bin/composer /usr/bin/composer

# Install phpcs and drupalcs
RUN composer global require drupal/coder && \
    phpcs --config-set installed_paths /root/.composer/vendor/drupal/coder/coder_sniffer/ \
    && phpcs --config-set default_standard Drupal,DrupalPractice

ENV PATH="${PATH}:/root/.composer/vendor/bin"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
