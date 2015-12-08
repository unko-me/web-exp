gulp = require 'gulp'
ghPages = require 'gulp-gh-pages'
config = require '../../data/config'

gulp.task 'deploy_gh', ->
  src = "./#{config.dest}/**/*"
  console.log "[gh-deploy] src", src
  gulp.src(src)
    .pipe(ghPages(
      cacheDir: '.build'
    ))