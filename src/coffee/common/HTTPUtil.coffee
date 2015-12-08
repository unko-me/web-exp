class HTTPUtil
  constructor: () ->

  @getUrlVars = ->
    vars = {}
    param = location.search.substring(1).split('&')
    i = 0
    while i < param.length
      keySearch = param[i].search(RegExp('='))
      key = ''
      if keySearch != -1
        key = param[i].slice(0, keySearch)
      val = param[i].slice(param[i].indexOf('=', 0) + 1)
      if key != ''
        vars[key] = decodeURI(val)
      i++
    vars

module.exports = exports = HTTPUtil