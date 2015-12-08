Stage = require "./Stage"
ScrollOffset = require "./ScrollOffset"

class ScrollManager extends EventEmitter2

  _offsets: null
  constructor: () ->
    super()
    $(window).on('scroll', _.throttle(@onScroll, 33))
    @_update()
    @_offsets = []
#
#    @tk = $('#tk')
#    @bigrun = $('#bigrun')
#    @tkOffset = new ScrollOffset(@tk)
#    @bigrunOffset = new ScrollOffset(@bigrun)
#    @makingOffset = new ScrollOffset($('#making'))
#    @separate1Offset = new ScrollOffset($('#separateVideo1'))
#    @separate2Offset = new ScrollOffset($('#separateVideo2'))
#    @_offsets = [@tkOffset, @bigrunOffset, @makingOffset, @separate1Offset, @separate2Offset]
#

    @updateOffset()

  updateOffset: =>
    for offset in @_offsets
      offset.updateOffset()

  resize: =>
    @updateOffset()

  _update: =>
    @top = window.scrollY || window.pageYOffset
    @bottom = @top + Stage.height

  onScroll: =>
    @_update()

    for offset in @_offsets
      offset.updateScroll(@top, @bottom)
    @emit('scroll')




module.exports = exports = new ScrollManager