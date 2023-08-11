#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme' --report=checkstyle -q . \
  | reviewdog -f="checkstyle" -name="drupal-coder (drupal)" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}" -filter-mode="${INPUT_FILTER_MODE}"

phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' --report=checkstyle -q  . \
  | reviewdog -f="checkstyle" -name="drupal-coder (drupal practice)" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}" -filter-mode="${INPUT_FILTER_MODE}"
