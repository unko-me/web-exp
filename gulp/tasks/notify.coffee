#notify_server

notify = require "gulp-notify"
gulp = require("gulp")


gulp.task "notify_server", ->
  gulp.src("./package.json")
  .pipe(notify(
      title: 'イヤッホーイ！！！'
      message: "build終わったので、いまからwatchしますね"
    ))