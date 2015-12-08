gulp = require 'gulp'
imgsizefix = require 'gulp-imgsizefix'
config = require '../../data/config'




gulp.task 'imgsizefix', ->
  options = {paths: {}}
  dest = "#{config.dest}/"
  options.paths[dest] = [config.cdnBasePath, new RegExp("^\\/")]

  gulp.src "#{config.dest}/**/*.html"
    .pipe imgsizefix options
    .pipe gulp.dest(dest)
  return