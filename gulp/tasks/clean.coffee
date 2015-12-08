gulp = require 'gulp'
del = require 'del'

config = require '../../data/config'

gulp.task 'clean', (cb)->
  del([config.dest, '.sass-cache'], cb)


