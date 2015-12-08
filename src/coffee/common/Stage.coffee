class Stage extends EventEmitter2
  constructor: () ->
    super()
    @$window = $(window)
#    @$window.on('resize', @resize)
    $(window).on('resize', _.throttle(@resize, 100))
    @resize()

  resize: =>
    console.log "[Stage] aaa", Stage.RESIZE
    @width = @$window.width()
    @height = @$window.height()
    @emit('resize', {@width, @height})

module.exports = exports = new Stage