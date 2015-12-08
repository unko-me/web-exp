
_STORAGE_KEY = 'canWebGL'
_STORAGE_ERROR_KEY = 'webGLCompileError'
class GLDetect
  @webgl: false

  constructor: () ->


  @detect: ->
    # もうtrueだったらinit後なので、返す
    if GLDetect.webgl
      return GLDetect.webgl

    # ローカルキャッシュから取得
    # キャッシュしないときは40msくらいかかる: document.createElement('canvas')が重い
    # キャッシュすると0.050ms以内で返却可能
    key = localStorage.getItem(_STORAGE_KEY)
    errorKey = localStorage.getItem(_STORAGE_ERROR_KEY)
    if key is 'true'
      GLDetect.webgl = true
      if errorKey is 'true'
        return false
      return true
    else if key is 'false'
      GLDetect.webgl = false
      @_delayCheck()
      return false

    # キャッシュがないとき
    GLDetect.webgl = @_detect()
    localStorage.setItem(_STORAGE_KEY, GLDetect.webgl.toString())
    return GLDetect.webgl

  @_detect: ->
    # iOSは8以上で可能
    if UA.ios
      return UA.ios8gt

    canWebGL = GLDetect.detectWebGL()

    # Androidは4.2以上でChrome + WebGL動くときにOK
    # Chromeは2015-05-08時点での最新 42以上にしておく
    if UA.android
      return @_checkAndroid(canWebGL)

    if UA.msie and UA.ieVersion < 11
      return false

    # それ以外はcanWebGLでOK
    return canWebGL

  @_checkAndroid: (canWebGL)->
    if UA.androidVersion >= 4.2 and UA.chrome and UA.chromeVersion > 41
      return canWebGL
    else
      return false

  # たまにAndroidでミスるときがあるのでdelayかけてチェックする
  @_delayCheck: ->
    setTimeout =>
      if UA.android
        canWebGL = GLDetect.detectWebGL()
        GLDetect.webgl = @_checkAndroid(canWebGL)
        if GLDetect.webgl
          localStorage.setItem(_STORAGE_KEY, GLDetect.webgl.toString())
    , 300



  @detectWebGL: ->
    try
      c = document.createElement('canvas')
      gl = if c.getContext != null then c.getContext('webgl') or c.getContext('experimental-webgl') else null
      if !!window['WebGLRenderingContext'] and gl
        #↓こっちだとたまにエラー
#      if !!window['WebGLRenderingContext'] and gl and gl.drawingBufferWidth >= 300 and gl.drawingBufferHeight >= 150
        return true
      else
        return false
    catch error
      return false


  # エラー端末の場合は強制
  @errorDevice: ->
    localStorage.setItem(_STORAGE_KEY, 'false')
    localStorage.setItem(_STORAGE_ERROR_KEY, 'true')



module.exports = exports = GLDetect