#!/bin/bash

npm install
bower install
bundle install --path vendor/bundle  --jobs=4
typings install
