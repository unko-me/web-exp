jadeConfig = require '../../data/jadeConfig'
data = jadeConfig()

config = require '../../data/config'
gulp = require("gulp")

{src, dest} = config

gulp.task "copyImg", ->
  gulp.src("#{src}/img/**/*").pipe(gulp.dest("#{dest}/img"))

gulp.task "copyMedia", ->
  gulp.src("#{src}/media/**/*").pipe(gulp.dest("#{dest}/media"))

gulp.task "copyFont", ->
  gulp.src("#{src}/font/**/*").pipe(gulp.dest("#{dest}/font"))

gulp.task "copySound", ->
  gulp.src("#{src}/sound/**/*").pipe(gulp.dest("#{dest}/sound"))
