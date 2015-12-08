Share = require "./../common/Share"
Track = require "./../common/Track"

class SP
  constructor: () ->
    console.log "[sp]"



Track.init()
$ ->
  new SP()
  setTimeout(->
    Share.init()
  , 1000)