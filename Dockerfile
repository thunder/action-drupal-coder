FROM alpine:3.11

ENV REVIEWDOG_VERSION=v0.9.17

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install phpcs and drupalcs
RUN composer global require drupal/coder

ENV PATH="${PATH}:${HOME}/.composer/vendor/bin"

RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
