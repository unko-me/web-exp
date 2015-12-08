fs = require 'fs'
bower_dir = JSON.parse(fs.readFileSync('.bowerrc', 'utf8')).directory + '/'
_ = require 'lodash'

config = require '../../data/config'

merge = require 'merge-stream'
gulp = require 'gulp'
concat = require 'gulp-concat'
replace = require 'gulp-replace'



baseLib = [
  "src/js/modernizr-custom.js"
  "#{bower_dir}jquery/dist/jquery.min.js"
  "#{bower_dir}lodash/lodash.min.js"
  "#{bower_dir}velocity/velocity.min.js"
  "#{bower_dir}eventemitter2/lib/eventemitter2.js"
#  "src/js/lib/eventemitter2.js"
  "#{bower_dir}gsap/src/minified/TweenMax.min.js"
]

files =
  'lib/lib.js': baseLib.concat([
    "#{bower_dir}/pixi.js/bin/pixi.min.js"
  ])
  'lib/lib_sp.js': _.clone(baseLib)




concatLib = (dest)->
  streams = []
  for key, value of files
    stream = gulp.src(value)
    .pipe(concat(key))
    #sourcemap削除
    .pipe(replace(/sourceMappingURL=.*\.map/g, ''))
    .pipe(gulp.dest(dest))
    streams.push stream

  merge.apply(@, streams)

gulp.task "libjs", ->
  concatLib("#{config.dest}/js")
