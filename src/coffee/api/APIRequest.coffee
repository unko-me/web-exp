

###
クエリパラメータが不正	400
tokenが不正	        401
snsが不正（未認証）	401
TwitterのAPI制限     429
SNS投稿時にエラー発生	500
###
NO_RETRY_ERROR_CODE = [400, 401, 404, 429, 500]

Config = require "../Config"
AjaxPool = require './AjaxPool'
class APIRequest
  @index: 0

  constructor: () ->

  post: (url, params, retryNum = 2, retryDelay = 1000)->
    @_fetch('POST', url, params, retryNum = 2, retryDelay = 1000)

  get: (url, params, retryNum = 2, retryDelay = 1000)->
    @_fetch('GET', url, params, retryNum = 2, retryDelay = 1000)


  _fetch: (type = 'post', url, params, retryNum = 2, retryDelay = 1000)->
    console.log '[APIRequest] type:', type, 'url:', url, 'params:', params
    q = new $.Deferred()

    count = 0
    APIRequest.index++
    _retryCheck = (res)=>
      if ++count <= retryNum
        setTimeout ->
          __fetch()
        , retryDelay
      else
        _error(res)
      console.log '[APIRequest] count', count

    _error = (res)->
      q.reject(res)
      if Config.debug
        alert("API Error\n#{url}")

    __fetch = =>
#      dfd = $[type](url, params).then (res)=>
      settings =
        type: type
        url: url
        data: params

      ajax = $.ajax(settings)
      ajax.id = APIRequest.index
      ajax.url = url
      AjaxPool.add ajax

      dfd = ajax.then (res)=>
        console.info '[APIRequest] fetch success', res
        unless res
          _retryCheck()
          return

        ## statusがある場合
#        if res.status and res.status is 'success'
#          q.resolve(res)
#        else if /\.json$/.test(url)
#          q.resolve(res)
        if res.error?
          _error(res)
        else
          q.resolve(res)

      , (res)=>
        console.error '[APIRequest] fetch error', res
        # リトライなしでエラーにいくやつ
        console.log 'res.status', res.status, typeof res.status
        if res.statusText is 'abort'
          _error(res)
          return
        if NO_RETRY_ERROR_CODE.indexOf(res.status) > -1
          console.error '[APIRequest] fetch error -> NO_RETRY_ERROR_CODEなのでNG'
          _error(res)
        else
          _retryCheck(res)

      dfd.always ()=>
        AjaxPool.remove ajax
        console.log '[APIRequest] fetch end'

    promise = q.promise()
    __fetch()
    return promise







module.exports = exports = new APIRequest()