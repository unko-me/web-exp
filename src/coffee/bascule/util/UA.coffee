class UA
  @ua: window.navigator.userAgent.toLowerCase()
  @win: false
  @mac: false

  @MSIE: false
  @ie6: false
  @ie7: false
  @ie8: false
  @ie9: false
  @ie10: false
  @ie11: false
  @msEdge: false

  @iPad: false
  @iPhone: false
  @ios: false
  @iosVersion: null
  @ios8gt: false

  @android: false
  @android2: false
  @androidVersion: null

  @chrome: false
  @chromeVersion: null

  @webkit: false
  @safari: false
  @firefox: false
  @smartphone: false
  @touchDevice: false
  @tablet: false



  @init: ->
    @win = @ua.indexOf('windows') > -1
    @mac = @ua.indexOf('mac') > -1
    @MSIE = @ua.indexOf('msie') > -1 or @ua.indexOf('trident') > -1
    @ie6 = @MSIE && @ua.indexOf('msie 6') > -1
    @ie7 = @MSIE && @ua.indexOf('msie 7') > -1
    @ie8 = @MSIE && @ua.indexOf('msie 8') > -1
    @ie9 = @MSIE && @ua.indexOf('msie 9') > -1
    @ie10 = @MSIE && @ua.indexOf('msie 10') > -1
    if @MSIE
      @ieVersion = parseFloat(@ua.match(/(msie\s|rv:)([\d\.]+)/)[2])
      @ieVersion = parseFloat(@ieVersion)
    @ie11 = @MSIE && @ieVersion is 11
    @msEdge = @ua.indexOf('edge/') > -1

    ###
    iOS
    ###
    @iPhone = @ua.indexOf('iphone') > -1 || @ua.indexOf('ipod') > -1
    @iPad = @ua.indexOf('ipad') > -1
    @ios = @iPhone or @iPad
    @iosLT6 = (@iPhone || @iPad) && @ua.indexOf('test')
    if @iPhone or @iPad
      v = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/)
      @iosVersion = [parseInt(v[1], 10), parseInt(v[2], 10), parseInt(v[3] || 0, 10)]
      @ios8gt = @iosVersion[0] > 7

    ###
    android
    ###
    @android = @ua.indexOf('android') > -1
    # 4.4.4 -> 4.4で返す
    @androidVersion = parseFloat(@ua.slice(@ua.indexOf("android")+8))


    @chrome = @ua.indexOf('chrome') > -1
    @webkit = @ua.indexOf('webkit') > -1
    @firefox = @ua.indexOf('firefox') > -1
    @safari = @ua.indexOf('safari') > -1 && !@chrome && !@android && !@iPhone && !@iPad

    @smartphone = @iPhone or @android
    @touchDevice = @iPhone or @iPad or @android
    #AndroidのタブレットにはMobileという文字列がない
    @tablet =  @iPad or (@android && @ua.indexOf('mobile') == -1)
    if @iPhone and screen.height is 480
      @iPhone4s = true

    @pc = !(@smartphone or @iPad)
    if @android
      verArray = /(android)\s([0-9]{1,})([\.0-9]{1,})/.exec(@ua)
      if verArray and verArray[2]
        ver = parseInt(verArray[2], 10);
      if ver is 2
        @android2 = true


    # S4ブラウザはChromeの文字列があるので
    if @ua.indexOf('SC-04E') > -1 and @ua.indexOf('Version') > -1
      @ua.chrome = false

    if @chrome
      verArray = /(chrome\/)([0-9]{1,})([\.0-9]{1,})/.exec(@ua)
      if verArray and verArray[2]
        @chromeVersion =  parseInt(verArray[2], 10);

  @initHtml: ->
    className = []
    if @mac
      className.push "mac"
    else if @win
      className.push "win"

    if @android
      className.push "android"
    else if @iPhone or @iPad
      className.push "ios"
    if @android2
      className.push "android2"

    if @iPhone4s
      className.push 'iphone4'

    if @firefox
      className.push "firefox"
    else if @webkit
      className.push "webkit"

    if @smartphone
      className.push 'sp'
    else
      className.push 'pc'

    if @tablet
      className.push 'tablet'
    else
      className.push 'notTablet'

    if @MSIE
      className.push 'ie'

    if @ie8
      className.push 'ie8'
    if @ie9
      className.push 'ie9'
    if @ie10
      className.push 'ie10'

    html = document.getElementsByTagName("html")[0]
    html.className += ' ' + className.join(" ")

UA.init()
UA.initHtml()
window.UA = UA
console.log 'window.UA:', window.UA

module.exports = exports = UA
