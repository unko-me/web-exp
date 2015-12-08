jadeConfig = require '../../data/jadeConfig'
data = jadeConfig()
config = require '../../data/config'

gulp = require("gulp")
jade = require("gulp-jade")
#newer = require 'gulp-newer'
cached = require 'gulp-cached'
plumber = require 'gulp-plumber'
rename = require 'gulp-rename'
util = require 'gulp-util'
gulpif = require 'gulp-if'

browserSync = require 'browser-sync'
runSequence = require 'run-sequence'
#mergeStream = require 'merge-stream'



dest = config.dest
jadeSrc = ["#{config.src}/jade/**/!(_)*.jade"]

# angularのpartialを使う時。
tmpl =
  src: ["./#{config.src}/jade/partials/**/*.jade"]
  dest:  "#{dest}/partials"


compile = (src, dest, cacheName, data, cache = true)->
  gulp.src(src)
    .pipe plumber()
    .pipe(gulpif(cache, cached(cacheName)))
    .pipe(jade(
        pretty: true
        data: data
      ))
    .pipe(gulp.dest(dest))
    .pipe(browserSync.reload(stream:true))

# 複数やるときはstreamにpushしておく
#compileAll = (data, cache)->
#  streams = []
#  streams.push compile(jadeSrc, dest, "jade:main", data, cache)
#
#  # index
#  streams.push compile("#{config.src}/jade/_common/index.jade", dest, "jade:main:index", _getData(config.LANG_NAMES[0], data), cache)
#  # connect
#  streams.push compile("#{config.src}/jade/_common/connect.jade", dest, "jade:main:connect", _getData(config.LANG_NAMES[0], data), cache)
#  return mergeStream streams...



gulp.task "jade:main", ->
#  compileAll(data, true)
  compile(jadeSrc, dest, 'jade:all', data)

gulp.task "jade:include", ->
#  compileAll(data, false)
  compile(jadeSrc, dest, 'jade:include', data, false)



gulp.task "jade:redirect", ->
  gulp.src(["./#{config.src}/jade/redirect.jade"])
    .pipe plumber()
    .pipe(cached('jade:redirect'))
    .pipe(jade(
      pretty: true
      data: data
    ))
    .pipe(rename('index.html'))
    .pipe(gulp.dest("#{dest}/redirect"))

gulp.task "jade:tmpl", ->
  compile(tmpl.src, tmpl.dest, 'jade:redirect', data)



#gulp.task 'html', ['jade:main']
#gulp.task 'html', ['jade:main', 'jade:redirect', 'jade:tmpl', 'imgsizefix']
gulp.task 'html', (callback) -> runSequence(['jade:main', 'jade:redirect', 'jade:tmpl'] ,'imgsizefix', callback)

gulp.task 'includeHtml', (callback) ->
  runSequence(['jade:include'] ,'imgsizefix', callback)

