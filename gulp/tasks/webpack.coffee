_ = require 'lodash'
gulp = require 'gulp'
gulpif = require 'gulp-if'
browserSync = require 'browser-sync'
webpack            = require("webpack-stream")
config = require '../../data/config'


gulp.task "webpack", ->
  gulp.src config.src
  .pipe webpack require "../../data/webpack.config.coffee"
  .pipe gulp.dest "#{config.dest}/js"