class CanvasDetector
  constructor: () ->

  @canWebGL: ->
    try
      return !!window.WebGLRenderingContext && !!document.createElement( 'canvas' ).getContext( 'experimental-webgl' )
    catch error
      return false


if typeof define is "function" and define.amd
  define ->
    CanvasDetector
# CommonJS
else if typeof exports is "object"
  exports.CanvasDetector = CanvasDetector
# Browser global.
else
  window.CanvasDetector = CanvasDetector

