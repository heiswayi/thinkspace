#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build
bundle exec htmlproofer _site --disable-external --allow-hash-href

remote="https://${GH_TOKEN}@github.com/namtx/namtx.github.io.git"

git config --global user.email "$GH_EMAIL" > /dev/null 2>&1
git config --global user.name "$GH_NAME" > /dev/null 2>&1

cd _site

git init
git remote add --fetch origin "$remote"

git add -A
git commit --allow-empty -m "$TRAVIS_COMMIT_MESSAGE"
git push origin master -q -f
