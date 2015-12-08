HandEvent = {}
do ->

  HandEvent.supportTouch = ("ontouchstart" of window) or window.DocumentTouch and document instanceof DocumentTouch
  HandEvent.click = 'click'

  if HandEvent.supportTouch
    HandEvent.TOUCH_START = 'touchstart'
    HandEvent.TOUCH_MOVE = 'touchmove'
    HandEvent.TOUCH_END = 'touchend'
  else
    HandEvent.TOUCH_START = 'mousedown'
    HandEvent.TOUCH_MOVE = 'mousemove'
    HandEvent.TOUCH_END = 'mouseup'


module.exports = exports = HandEvent