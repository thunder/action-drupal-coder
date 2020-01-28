FROM php:7.4-cli-alpine3.11
FROM composer:1.9.1 as composer-build

ENV REVIEWDOG_VERSION=v0.9.17

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY --from=composer-build /usr/bin/composer /usr/bin/composer

# Install phpcs and drupalcs
RUN composer global require drupal/coder

ENV PATH="${PATH}:/root/.composer/vendor/bin"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
