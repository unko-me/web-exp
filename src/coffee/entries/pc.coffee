Stage = require "./../common/Stage"
ScrollManager = require "./../common/ScrollManager"
Track = require "./../common/Track"


class PC
  constructor: () ->
    Stage.on('resize', @resize)
    ScrollManager.on('scroll', @scroll)

  resize: =>
  scroll: =>

#Track.init()

$ ->
  new PC()