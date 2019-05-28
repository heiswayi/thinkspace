#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build
bundle exec bin/htmlproofer ../_site --disable-external
