#!/bin/sh
set -e
rm -rf _site
mkdir -p _site
cp -R site/. _site/
sphinx-build -b html doc _site/doc
