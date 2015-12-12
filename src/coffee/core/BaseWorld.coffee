#= require ../com/katapad/util/CanvasDetector
#= require ../requestAnimationFrame

class BaseWorld
  scene: null
  camera: null

  ###*
  option
  option.rendererParams : new WebGLRenderer(rendererParams)
  option.clear
  option.clear.alpha
  option.clear.color

  ## example
  super(
      rendererParams:
        preserveDrawingBuffer: true
      amibientLight:
        color: 0x333333
      clear:
        color: 0x000000
        alpha: 0.9
    )
  ###
  constructor: (@option) ->
    @scene = new THREE.Scene()
    @setup()

  setup: =>
    @setupCamera()
    @setupRenderer()
    @setupLights()
    @setupControl()
    @initNotify()
    @_setup()

  _setup: ->


  initNotify: ->
    $('.notify').delay(2000).fadeOut(1000)

  setupCamera: ->
    @camera = new THREE.PerspectiveCamera(75, 600 / 400, .1, 5000)
    @_setupCameraPos()
    @_setupCameraLookAt()

  _setupCameraLookAt: ->
    @camera.lookAt(new THREE.Vector3())

  _setupCameraPos: ->
    @camera.position.set(400, 1200, 700)

  setupRenderer: ->
#    if (CanvasDetector.canWebGL())
    if (Modernizr.webgl)
      @renderer = new THREE.WebGLRenderer(@option?.rendererParams)
    else
      @renderer = new THREE.CanvasRenderer()

    window.addEventListener('resize', @onWindowResize)
    @onWindowResize()

    @_setupClearColor()
    document.getElementById('renderer').appendChild(@renderer.domElement)

  _setupClearColor: ->
    clearColor = @option?.clear?.color || 0
    clearAlpha = @option?.clear?.alpha || 1
    @renderer.setClearColor(clearColor, clearAlpha)
    @renderer.autoClearColor = false

  setupLights: ->
    @_setupDirectionalLight()
    @_setupAmbientLight()

  _setupAmbientLight: ()->
    if @option?.amibientLight
      @scene.add(new THREE.AmbientLight(@option?.amibientLight.color))

  _setupDirectionalLight: ->
    @_directionalLight = new THREE.DirectionalLight(0xffffff, 2)
    @_directionalLight.position.set(0, 300, 100)
    @scene.add(@_directionalLight)
#    lightHelper = new THREE.DirectionalLightHelper(@_directionalLight, 50)
#    @scene.add(lightHelper);


  setupControl: ->
    @control = new THREE.TrackballControls(@camera, @renderer.domElement)


  onWindowResize: =>
    @camera.aspect = window.innerWidth / window.innerHeight;
    @camera.updateProjectionMatrix();

    @renderer.setSize( window.innerWidth, window.innerHeight );


  render: =>
    @renderer.render(@scene, @camera)


  update: =>
    @control?.update()
    @_update()
    @render()

    requestAnimationFrame(@update)

  _update: ->


  startLoop: ->
    @update()




if typeof define is "function" and define.amd
  # AMD. Register as an anonymous module.
  define ->
    BaseWorld
else if typeof exports is "object"
  # CommonJS
  exports.BaseWorld = BaseWorld
else
  # Browser global.
  window.BaseWorld = BaseWorld