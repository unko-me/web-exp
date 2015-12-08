gulp = require 'gulp'
watch = require 'gulp-watch'
browserSync = require 'browser-sync'
config = require '../../data/config'



gulp.task 'watch', ->

#  watch時にcssがないと、動かないっぽい。cleanしてると動かない
  gulp.watch "#{config.dest}/**/*.css", (changeFile)->
    console.log 'changeFile:', changeFile
    gulp.src("#{config.dest}/**/*.css")
      .pipe(browserSync.reload(stream: true))
    return


  ## HTML
  gulp.watch ["#{config.src}/**/!(_)*.jade",], ["html"]    # _から始まらないものは、そのファイルだけコンパイル
  gulp.watch ["#{config.src}/**/_*.jade"], ["includeHtml"] # _から始まるjadeは全部コンパイル



  #  gulp.watch "#{config.src}/font/**/*", ["copyFont"]
  gulp.watch "#{config.src}/img/**/*", ["copyImg"]
  gulp.watch "#{config.src}/media/**/*", ["copyMedia"]
#  gulp.watch "#{config.src}/coffee/include/*.coffee", ["includejs","html"]

  gulp.watch ["#{config.src}/**/*.coffee"], ["webpack"]
  watch "#{config.dest}/**/*.js", ()->
    browserSync.reload()



  return



