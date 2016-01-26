fs = require 'fs'
bower_dir = JSON.parse(fs.readFileSync('.bowerrc', 'utf8')).directory + '/'
_ = require 'lodash'

config = require '../../data/config'

merge = require 'merge-stream'
gulp = require 'gulp'
concat = require 'gulp-concat'
replace = require 'gulp-replace'



baseLib = [
  "node_modules/jquery/dist/jquery.min.js"
#  "node_modules/lodash/lodash.min.js"
  "node_modules/eventemitter2/lib/eventemitter2.js"
  "node_modules/gsap/src/minified/TweenMax.min.js"
  "node_modules/stats.js/build/stats.min.js"
  "node_modules/dat.gui/dat.gui.min.js"
  "#{config.src}/js/lib/modernizr.custom.webgl.js"
]

files =
  'lib/lib.js': baseLib.concat([
    "#{bower_dir}/three.js/three.min.js"
    "node_modules/pixi.js/bin/pixi.min.js"
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
