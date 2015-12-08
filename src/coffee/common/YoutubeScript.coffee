
###
Youtubeのiframe apiのスクリプト埋め込みクラス
  youtubeScript.setup()後に
  @emit('ready')して教えてくれる
###
class YoutubeScript extends EventEmitter2
  constructor: () ->
    @isReady = false

  setup: =>
    window.onYouTubeIframeAPIReady = @onYouTubeIframeAPIReady
    tag = document.createElement('script')
    tag.src = 'https://www.youtube.com/iframe_api'
    firstScriptTag = document.getElementsByTagName('script')[0]
    firstScriptTag.parentNode.insertBefore tag, firstScriptTag

  onYouTubeIframeAPIReady: =>
    @emit("ready")
    @isReady = true


module.exports = exports = new YoutubeScript
