gulp = require 'gulp'
browserSync = require 'browser-sync'
config = require '../../data/config'

# 初回サーバー起動時にjsがない状態になってるので、リロードして回避
gulp.task 'firstReload', ->
  setTimeout(browserSync.reload, 5000)

gulp.task 'browser-sync', ->
  browserSync(
    port: config.local.port
    browser: 'Google Chrome Canary'
    open: false
#    injectChanges: false
    timestamps: true
    server: {
      baseDir: config.dest
    },
    ghostMode: {
      clicks: true
      location: true
      forms: true
      scroll: true
    }
    logPrefix: config.http_path
#    reloadDelay: 200
  )