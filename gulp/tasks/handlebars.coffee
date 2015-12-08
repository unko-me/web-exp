gulp = require('gulp')
handlebars = require('gulp-compile-handlebars')
rename = require('gulp-rename')
config = require '../../data/config'



gulp.task 'makeConfig', ->

  options =
    ignorePartials: true
#    partials: footer: '<footer>the end</footer>'
#    batch: [ './src/partials' ]
#    helpers: capitals: (str) ->
#      str.toUpperCase()
  gulp.src('src/**/*.hbs')
    .pipe(handlebars(config, options))
    .pipe(rename(extname: ""))
    .pipe gulp.dest('src')
