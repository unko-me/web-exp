gulp = require 'gulp'
ghPages = require 'gulp-gh-pages'
config = require '../../data/config'

gulp.task 'deploy_gh', ->
  gulp.src("#{config.dest}/**/*")
    .pipe(ghPages())