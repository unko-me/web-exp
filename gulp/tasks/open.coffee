gulp = require 'gulp'
open = require 'gulp-open'

config = require '../../data/config'


console.log 'config.openURL:', config.openURL
console.log 'notOpen:', config.notOpen

gulp.task "open", ->
  options =
    uri: config.openURL
    app: "Google Chrome Canary"

  gulp.src(__filename).pipe open(options)
  return

