unless window.requestAnimationFrame
  window.requestAnimationFrame = window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame

#if !window.requestAnimationFrame
#  window.requestAnimationFrame = do ->
#    window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (callback, element) ->
#      window.setTimeout callback, 1000 / 60
#      return
#
