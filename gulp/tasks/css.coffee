gulp = require 'gulp'
config = require '../../data/config'
plumber = require 'gulp-plumber'
browserSync = require 'browser-sync'
util = require 'gulp-util'
_ = require 'lodash'

exec = require 'gulp-exec'


#ダミー用ファイル生成
string_src = (filename, string) ->
  src = require("stream").Readable(objectMode: true)
  src._read = ->
    @push new util.File(
      cwd: ""
      base: ""
      path: filename
      contents: new Buffer(string)
    )
    @push null
    return
  src


compassConfig =
  config_file: "#{config.src}/sass/config.rb"
  css: "#{config.dest}/css"
  sass: "#{config.src}/sass"
  image: "#{config.dest}/img"
  font: "#{config.dest}/font"

#  relative: true
  environment: if config.env.production then 'production' else 'development'
  style: if config.env.production then 'compressed' else 'nested'

#    project: ''
  import_path: "#{config.src}/sass/import"
  bundle_exec: true
  sourcemap: config.debug # supported 1.0.0
  debug: config.debug


gulp.task "css-dummy" , (callback)->
  string_src("index.css", 'hoge')
  .pipe(gulp.dest("#{config.dest}/css/"))



css = (watch)->
  conf = _.cloneDeep compassConfig
  confList = ["bundle exec compass"]
  if watch
    confList.push 'watch'
  else
    confList.push 'compile'

  confList.push '--environment ' + conf.environment
  confList.push "-c #{conf.config_file}"
  confList.push '--relative-assets'
  if conf.debug
    confList.push '--debug-info --sourcemap'
  confList.push "--fonts-dir #{conf.font}"
  confList.push "--output-style #{conf.style}"
  confList.push "--images-dir #{conf.image}"
  confList.push "--css-dir #{conf.css}"
  confList.push "--sass-dir #{conf.sass}"
  confList.push " -I #{conf.import_path}"

  execStr = confList.join(" ")
  console.log 'execStr:', execStr
  gulp.src('package.json')
    .pipe(exec(execStr))

#  if watch
#    conf.watch = true
#  gulp.src("#{config.src}/sass/**/*.sass")
#    .pipe plumber()
#    .pipe(compass(conf))
#    .pipe gulp.dest("#{config.dest}/css")



gulp.task "css" , (callback)->
  css(false)

gulp.task "css_watch" , (callback)->
  css(config.isWatching)

