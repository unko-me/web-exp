gulp = require 'gulp'
webpack = require("webpack-stream")
config = require '../../data/config'
plumber = require 'gulp-plumber'

gulp.task "webpack", ->
  gulp.src config.src
  .pipe plumber()
  .pipe webpack require "../../data/webpack.config.coffee"
  .pipe gulp.dest "#{config.dest}/js"