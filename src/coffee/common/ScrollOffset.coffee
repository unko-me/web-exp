Stage = require "./Stage"

###
スクロール量を取得するクラス
  @percent: 自身のスクロール量。 画面内に入っているときは0-1の量。それ以外は
  * 0より小さい(要素がブラウザ画面の下のほうにある状態)
  * 1より大きい(要素がブラウザ画面の上のほうにスクロールした状態)

  このクラス自体はresizeイベントもscrollイベントも監視しない。
  ので、このクラスを抱合する側のほうでscrollなどを渡してあげる

  @offset = new ScrollOffset($('#hoge'))
  @offset.updateOffset()

  onresize = =>
    @offset.updateOffset()
  onscroll = =>
    @offset.updateScroll(scrollTop, scrollBottom)

###
class ScrollOffset extends EventEmitter2
  ###
  @parasm $target {jquery} スクロール量を知りたい要素のjqueryオブジェクト。
  ###
  constructor: (@$target) ->
    super()
    @updateOffset()

  ###
  スクロール量を超えたらイベント'trigger'を発行するのを設定する
  @params triggers {array} [0.5, 0.6, 0.8]などとして設定。
  percentが0.5, 0.6, 0.7を超えた場合にイベントが飛ぶ
  飛んでくるイベントは 'trigger', {percent: 0.5, i: 0} 。percentとtriggersのindex。
  ###
  setTriggers:(triggers)=>
    @triggers = []
    for percent, i in triggers
      @triggers.push {percent, i}

  ###
  リサイズ時にoffsetを再計算する
  ###
  updateOffset: =>
    @offset = @_updateOffset(@$target)

  ###
  スクロール値をアップデートする
  ###
  updateScroll: (scrollTop, scrollBottom)=>
#    console.log "[ScrollOffset] scrollTop", scrollTop, "scrollBottom", scrollBottom,  "@offset.top", @offset.top, "@offset.bottom",@offset.bottom
    if scrollTop <= @offset.top <= scrollBottom
#      console.log "[ScrollOffset] TOPは見えてます"
      @showTop = true
    else
#      console.log "[ScrollOffset] top見えてない"
      @showTop = false

    if scrollTop <= @offset.bottom <= scrollBottom
#      console.log "[ScrollOffset] bottomは見えてます"
      @showBottom = true
    else
#      console.log "[ScrollOffset] bottom見えてない"
      @showBottom = false

    @topPercent2 = (scrollBottom - @offset.top) / @offset.height
    @bottomPercent2 = (scrollTop - @offset.bottom) / @offset.height
    @scrollPx = scrollBottom - @offset.top

    @topPercent = (scrollBottom - @offset.top) / Stage.height
    @bottomPercent = (scrollTop - @offset.bottom) / Stage.height

    @percent = (scrollBottom - @offset.top) / (Stage.height + @offset.height)

    if @triggers
      @checkTriggers()

  checkTriggers: =>
    remain = []
    for trigger in @triggers
      if trigger.percent < @topPercent
        @emit('trigger', trigger)
      else
        remain.push trigger

    if @triggers.length > remain.length
      @triggers = remain

  contains: =>
    @showTop or @showBottom

  _updateOffset: (target)=>
    offset = target.offset()
    offset.height = target.height()
    offset.bottom = offset.top + offset.height
    return offset

module.exports = exports = ScrollOffset
