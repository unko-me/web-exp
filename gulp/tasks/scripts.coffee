_ = require 'lodash'

gulp = require 'gulp'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
util = require 'gulp-util'

config = require '../../data/config'

bundleLogger = require '../util/bundleLogger'
handleErrors = require '../util/handleErrors'

dest = "./#{config.src}/js/include/"

#gulp.task 'coffee', ->
#  gulp.src("#{config.src}/**/*.coffee")
#    .pipe(coffee({bare:true}))
#    .pipe gulp.dest(dest)

gulp.task 'includejs', ->
  gulp.src("#{config.src}/coffee/include/**/*.coffee")
    .pipe(coffee({bare:false}))
    .pipe(uglify())
    .pipe gulp.dest(dest)

#  gulp.src("#{config.src}/coffee/include/zoomfix.coffee")
#    .pipe(coffee({bare:false}))
#    .pipe(uglify())
#    .pipe gulp.dest(dest)

#gulp.task 'eventemitter', ->
#  gulp.src('vendor/bower/eventemitter2/lib/eventemitter2.js')
#  .pipe(uglify())
#  .pipe gulp.dest('vendor/bower/eventemitter2/lib/min/eventemitter2.min.js')
