#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

phpcs --standard=Drupal . \
  | reviewdog -efm="%f:%l:%c: %m" -name="linter-name (phpcs)" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"
