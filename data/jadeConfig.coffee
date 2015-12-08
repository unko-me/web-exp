config = require './config'
meta = require './meta'
_ = require 'lodash'

BASE_DATA = meta.BASE_DATA


module.exports = exports = (inherit={})->

  data = _.merge _.clone(inherit,true),do (inherit)->

    alt: require './alt'
    consts: require './consts'
    debug: config.debug
    env: config.env

    bodyClass: ''
    pageClass: ''
    pageName: 'index'

    baseDir: config.cdnBasePath
    homeDir: config.homeDir
    apiURL:  config.api.APIBasePath
    jsonURL:  config.api.JSONBasePath

    img: "#{config.cdnBasePath}img"
    css: "#{config.cdnBasePath}css"
    js: "#{config.cdnBasePath}js"
    media: "#{config.cdnBasePath}media"

    meta: BASE_DATA

    sns: meta.sns

  return data
