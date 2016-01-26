#define [
#], ->
#    "use strict"

output = typeof $ != "undefined" && $("#output")
if output.length == 0
  output = null
cache = ""

class Log
  @disabled: false
  @included: /^.*$/
  @excluded: /^$/
  @alertOnError: false

  clearCache: ->
    cache = "- cleared cache -<br>"

  constructor: (@subroutine)->


  out: (mtd, text, args...) ->
    if !Log.disabled and console?
      text = "#{@subroutine} | " + text
      if Log.included.test(text) and !Log.excluded.test(text)
        if console[mtd]?
          console[mtd] text, args...
        if output
          args.unshift(text)
          cache += args.join(" ")+"<br>"
          output.html cache
        if mtd == "error" and Log.alertOnError then alert "ERROR: #{text} "+args.join(", ")

  trace: (args...) ->
    if !@disabled
      @out "log", args...

  info: (args...) ->
    if !@disabled
      @out "info", args...

  event: (event, args...) ->
    if !@disabled
      @out "info", "#{event} |", args..., " -> new"

  handleEvent: (event, text, args...) ->
    if !@disabled
      @out "info", "event -> #{event} |", args...

  waiting: (forObject, args...) ->
    if !@disabled
      @out "info", "waiting | ", #{forObject} , "  ~  ", args...

        warn: (text, args...)->
          if !@disabled
            @out "warn", "warn | ", text, args...

        error: (text, args...)->
          if !@disabled
            @out "error", "error | ", text, args...

        milestone: (text, args...) ->
          if !@disabled
            @out "info", "milestone | ~~~~ #{text.toUpperCase()} ~~~~ ", args...

        onError: (error) =>
          if !@disabled
            @out "error", error

module.exports = Log