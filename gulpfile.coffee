gulp = require 'gulp'
runSequence = require('run-sequence')
config = require './data/config'

require './gulp'

gulp.task 'default', ->
  console.log 'default is not defined'
  console.log config

prebuild = ['makeConfig', 'includejs', 'copyImg', 'copyMedia']
minTask = ['imagemin_all']


gulp.task 'build', (callback) -> runSequence(
  prebuild ,
  ['html', 'css', 'libjs', 'webpack'],
  minTask,
  callback)

gulp.task 'build-for-server', (callback) ->
  tasks = ['html', 'css', 'libjs']
  if config.clean
    return runSequence('clean', prebuild ,tasks, callback)
  else
    return runSequence(prebuild ,tasks, callback)

gulp.task 'server', (callback) ->
  config.isWatching = true

  return runSequence(
    ['browser-sync', 'build-for-server'],
  #  'notify_server',
    ['open', 'css_watch', 'watch', 'webpack', 'firstReload'], callback)


gulp.task 'logURL', (callback) ->
  path = require "path"
  url = path.join(config.cdnAbsBasePath, config.cdnBasePath)
  console.log url
  callback()


gulp.task 'deploy', (callback) -> runSequence('clean' , 'build', 'deploy_gh', 'logURL', callback)
