class AjaxPool
  @pool: {}
  @add: (ajax)->
    AjaxPool.pool[ajax.id.toString()] = ajax
#    console.log '@pool add:', @pool, ajax.id


  @remove: (ajax)->
    id = ajax.id.toString()
    delete AjaxPool.pool[id]
#    console.log '@pool remove:', @pool, ajax.id

  @getFromURL: (url)->
    for id, ajax of AjaxPool.pool
      if ajax.url is url
        return ajax
        break

window.AjaxPool = AjaxPool
module.exports = exports = AjaxPool
