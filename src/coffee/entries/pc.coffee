#Stage = require "./../common/Stage"
#ScrollManager = require "./../common/ScrollManager"
#Track = require "./../common/Track"
#
#
#class PC
#  constructor: () ->
#    Stage.on('resize', @resize)
#    ScrollManager.on('scroll', @scroll)
#
#  resize: =>
#  scroll: =>
#
##Track.init()
#
#$ ->
#  new PC()


#$ = require "jquery"
#THREE = require "three.js"
console.log 'test', THREE
console.log "[pc] うえーい"

#perlin = require '../lib/perlin.js'
#console.log "[pc] perlin", perlin

class pc
  constructor: () ->
    @pos = new THREE.Vector2()
    @pos.add(new THREE.Vector2(10, 10))


module.exports = exports = pc