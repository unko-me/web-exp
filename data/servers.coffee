_ = require 'lodash'
ip = require('my-ip')(null, false)


LOCAL_API_PORT = 12000
LOCAL_SERVER_PORT = 8888


# APIサーバーの向き先
API_URL =
  production: 'http://honban.api.com/'
  staging:    'http://staging.api.com/'
  develop:    'http://dev.api.com/'
  local:      "http://#{ip}:#{LOCAL_API_PORT}"

# APIサーバーから生成されるJSON置き場
API_JSON_URL =
  production: 'http://honban.api.com/json/'
  staging:    'http://staging.api.com/json/'
  develop:    'http://dev.api.com/json/'
  local:      "http://#{ip}:#{LOCAL_API_PORT}"

# CDN
CDN_URL =
  production: '/'
  staging:    '/'
  develop:    '/'
  local:      "/"

# 絶対パスで見たいとき用(OG:Imageのパスとか)
CDN_ABS_URL =
  production: 'http://unko-me.github.io/'
  staging:    'http://unko-me.github.io/'
  develop:    'http://unko-me.github.io/'
  local:      "http://#{ip}:#{LOCAL_SERVER_PORT}"

# S3
S3 =
  production: 'prod-example-bucket'
  staging:    'staging-example-bucket'
  develop:    'dev-example-bucket'


module.exports = {CDN_URL, CDN_ABS_URL, API_URL, API_JSON_URL, LOCAL_API_PORT, LOCAL_SERVER_PORT, ip, S3}
