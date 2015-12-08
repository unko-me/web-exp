gulp = require 'gulp'
imagemin = require 'gulp-imagemin'
pngquant  = require 'imagemin-pngquant'


gulp.task 'imagemin_all', ->
  gulp.src('public/img/**/*')
  .pipe(imagemin(
      progressive: false
      optimizationLevel: 3
#      use: [pngquant()]
    ))
  .pipe(gulp.dest('public/img/'));

gulp.task 'compass_imagemin', ->
#  game-s89ea5951e5.png
  gulp.src(['public/img/**/*-s**********.png'])
  .pipe imagemin(
#    optimizationLevel: 10
    use: [
      pngquant
        quality: 80
        speed: 1
    ]
  )
  .pipe gulp.dest('public/img/')

gulp.task 'imagemin', ->
  gulp.src('public/img/**/*.png')
  .pipe imagemin(
#    optimizationLevel: 10
  )
  .pipe gulp.dest('public/img/')


