#!/bin/bash
# copy _site/ to local www directory
rsync -av --delete _site/ ~/www/qbox/html
chmod -R go+rX ~/www/qbox/html
