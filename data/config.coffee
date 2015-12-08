{CDN_URL, CDN_ABS_URL, API_URL, API_JSON_URL, LOCAL_API_PORT, LOCAL_SERVER_PORT, ip} = require './servers.coffee'

pkg = require '../package.json'
gulp = require 'gulp'
gutil = require 'gulp-util'
URL = require "url"
path = require "path"

http_path = pkg.develop.http_path
revision = gutil.env['build-version'] or gutil.date(Date.now(), 'yyyy-mm-dd_HH-MM-ss')
uploadPath = path.normalize "#{http_path}/assets/#{revision}"
notOpen = gutil.env.open is false

_envCheck = (value)->
  result =
    production: value is 'production'
    staging: value is 'staging'
    develop: value is 'develop'
    local: false
    value: value

  if value is '' or !value
    result.value = 'local'
    result.local = true
  return result


# enviroment
{production, staging, develop, local, value} = _envCheck(gutil.env.env)
env = _envCheck(gutil.env.env)

# debugモード
debug = if env.production or env.staging then false else true

# publicフォルダをcleanする/しない(Server時のみ)
noClean = gutil.env.noclean is 'true'
clean = !noClean

# API Enviroment
apiEnv = _envCheck(gutil.env.api)

# CDN Path
cdnBasePath = do ->
  return if env.local
    return '/'
  else
    return URL.resolve CDN_URL[env.value],  "#{http_path}/assets/#{revision}/"

cdnAbsBasePath = CDN_ABS_URL[env.value]


# homeDir
#homeDir = do ->
#  if production
#    return CDN_URL.production
#  else if develop
#    return CDN_URL.develop + uploadPath
#  return '/'

# 開くときのURL
openURL = do ->
  if env.local
    return "http://#{ip}:#{LOCAL_SERVER_PORT}"
  else
    return URL.resolve CDN_URL[env.value], uploadPath


# APIの向き先決定
apiBase =
  APIBasePath: API_URL[apiEnv.value]
  JSONBasePath: API_JSON_URL[apiEnv.value]

config =
  # デバッグモード
  debug: debug
  #リビジョン番号。cliからの指定がなければ今の日付。YYYY-MM-DD_hh-mm-ss
  revision: revision
  # ファイルを置く環境
  env: env
  #APIの環境
  apiEnv: apiEnv
  # ローカル情報
  local:
    ip: ip
    port: LOCAL_SERVER_PORT

  # APIの向き先
  api: apiBase

  # CDNのディレクトリ。http://cdn.com/assets/YYYY-MM-DD_hh-mm-ss/となる
  cdnBasePath: cdnBasePath

  # CDNの絶対パス
  cdnAbsBasePath: cdnAbsBasePath

  # server時にブラウザで開くURL
  openURL: openURL

  # server時にブラウザで開くかどうか
  notOpen: notOpen


  uploadPath: uploadPath



  # srcディレクトリ
  src: pkg.develop.src
  # destディレクトリ
  dest: pkg.develop.dest
  #アップロードするとこのhttp_path (example.com/xmasならxmas)
  http_path: pkg.develop.http_path
  #ほかいろいろ
  pkgConfig: pkg.develop

# publicフォルダをcleanする/しない(Server時のみ)
  clean: clean

  consts: require '../data/consts'


console.log 'config:', config

module.exports = exports = config
