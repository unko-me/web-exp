###
/src/coffee/include/redirect.coffee も参照。
###

class Storage
  constructor: () ->

    ###
    JSONオブジェクトに変換して読み出し
    @param key:String
    ###
  @readJSON: (key)->
    dataStr = @readRaw(key)
    if dataStr
      return JSON.parse dataStr
    else
      return null

  ###
  Stringで読み出し。JSONではないよ。
  @return String
  ###
  @readRaw: (key)->
    localStorage.getItem(key)

  ###
  書き込み。
  @param key:String キー
  @param json:Object jsonオブジェクト。stringではない。
  ###
  @writeJSON: (key, json)->
    @writeRaw key,JSON.stringify(json)

  ###
  生データ書き込み。単純なデータ等に。
  @param key:String キー
  @param value:String 値
  ###
  @writeRaw: (key, value)->
    localStorage.setItem(key, value)

  @remove: (key)->
    localStorage.removeItem(key)

  @clearAll: (keys)->
    for key in keys
      @remove key
#    localStorage.clear()

module.exports = exports = Storage