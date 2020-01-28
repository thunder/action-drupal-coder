#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme' --report=checkstyle -q .

phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme' --report=checkstyle -q . \
  | reviewdog -f="checkstyle" -name="drupal-coder (drupal)" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"

phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' --report=checkstyle -q  . \
  | reviewdog -f="checkstyle" -name="drupal-coder (drupal practice)" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"
