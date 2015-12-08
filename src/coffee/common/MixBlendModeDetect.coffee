
###
css3 mix-blend-modeの検出クラス
  Safari 9が一部のブレンドモードしか検出しないので
  supportsMixBlendModeColor というのがある
###
class MixBlendModeDetect
  @supportsMixBlendMode: false
  @supportsMixBlendModeColor: false
  @supportsBackgroundBlendMode: false
  @supportsIsolation: false

  ###
  ブレンドモードが使えるかのチェック
  ###
  @detect: =>
    if MixBlendModeDetect._isCheck
      return true
    if 'CSS' of window and 'supports' of window.CSS
      @supportsMixBlendMode = window.CSS.supports('mix-blend-mode', 'multiply')
      @supportsMixBlendModeColor = window.CSS.supports('mix-blend-mode', 'color')
      @supportsBackgroundBlendMode = window.CSS.supports('background-blend-mode', 'multiply')
      @supportsIsolation = window.CSS.supports('isolation', 'isolate')

    @_isCheck = true

  ###
  bodyなどに検知結果のクラスを付与する
  ###
  @addClass: (element)->
    cls = ''
    if @supportsMixBlendMode
      cls += ' mixBlendMode'
    if @supportsMixBlendModeColor
      cls += ' mixBlendModeColor'
    element.className += cls

module.exports = exports = MixBlendModeDetect
