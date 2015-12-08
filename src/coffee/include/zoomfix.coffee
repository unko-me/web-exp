window.zoomfix = class zoomfix
  @width:640
  @scale:1
  @elements:[]
  @add:(element)->
    if @elements.indexOf(element) >= 0 then return
    @elements.push element
  @remove:(element)->
    index = @elements.indexOf element
    if index < 0 then return
    @elements.splice index,1
  @execute:->
    width = window.innerWidth or screen.width
    scale = width / @width
    if @scale isnt scale then @scale = scale
    width = "#{@width * scale}px"
    if @elements.length
      document.documentElement.style.width = width
      document.documentElement.style.zoom = 1
      document.body?.style.width = width
      for element in @elements then element?.style.zoom = scale
    else
      document.documentElement.style.zoom = scale
  constructor:-> do zoomfix.execute

# prezoomfix
if not window.navigator.userAgent.match(/iPhone/) then do window.zoomfix
