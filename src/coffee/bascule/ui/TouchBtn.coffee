HandEvent = require "./../event/HandEvent"
console.log "[TouchBtn] ", HandEvent, HandEvent.TOUCH_START
class TouchBtn
  constructor: () ->
  @init: (className = '.touchBtn')=>
    $(className).on(HandEvent.TOUCH_START, (event)=>
      $target = $(event.currentTarget)
      $target.addClass 'onTouch'
      $(document).one(HandEvent.TOUCH_END, =>
        $target.removeClass 'onTouch'
      )
    )


module.exports = exports = TouchBtn
