# action-drupal-coder

<!-- TODO: replace chrfritsch/action-drupal-coder with your repo name -->
[![Test](https://github.com/chrfritsch/action-drupal-coder/workflows/Test/badge.svg)](https://github.com/chrfritsch/action-drupal-coder/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/chrfritsch/action-drupal-coder/workflows/reviewdog/badge.svg)](https://github.com/chrfritsch/action-drupal-coder/actions?query=workflow%3Areviewdog)
[![depup](https://github.com/chrfritsch/action-drupal-coder/workflows/depup/badge.svg)](https://github.com/chrfritsch/action-drupal-coder/actions?query=workflow%3Adepup)
[![release](https://github.com/chrfritsch/action-drupal-coder/workflows/release/badge.svg)](https://github.com/chrfritsch/action-drupal-coder/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/chrfritsch/action-drupal-coder?logo=github&sort=semver)](https://github.com/chrfritsch/action-drupal-coder/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

This is a GitHub action that checks your drupal module against the drupal coding styles (Drupal, DrupalPractice) and outputs the warnings and errors using [reviewdog](https://github.com/reviewdog/reviewdog).

By default only issues in added/modified lines are reported.

## Input

<!-- TODO: update -->
```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN'
    default: '${{ github.token }}'
  ### Flags for reviewdog ###
  filter_mode:
    description: 'Filter results by diff or file [added, diff_context, file, nofilter]'
    default: 'added'
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  reporter:
    description: 'Reporter of reviewdog command.'
    default: 'github-pr-check'

```

## Usage
<!-- TODO: update. replace `template` with the linter name -->

```yaml
name: reviewdog
on: [pull_request]
jobs:
  # TODO: change `linter_name`.
  linter_name:
    name: runner / action-drupal-coder
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: chrfritsch/action-drupal-coder@v1
        with:
          github_token: ${{ secrets.github_token }}
          # Possible filter modes [added, diff_context, file, nofilter]'
          filter_mode: added
          # Possible reviewdog reporter [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```
