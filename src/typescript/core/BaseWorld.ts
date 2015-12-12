import WebGLRendererParameters = THREE.WebGLRendererParameters;
import Scene = THREE.Scene;
import Camera = THREE.Camera;
import Renderer = THREE.Renderer;
import WebGLRenderer = THREE.WebGLRenderer;
import DirectionalLight = THREE.DirectionalLight;
import PerspectiveCamera = THREE.PerspectiveCamera;
import TrackballControls = THREE.TrackballControls;

require('../../js/lib/three/controls/TrackballControls.js');

export class BaseWorld {
  public scene:Scene;
  public camera:Camera;
  public renderer:Renderer;
  protected _directionalLight:DirectionalLight;
  protected control:TrackballControls;

  constructor(protected option:any) {
    this.scene = new Scene();
    this.setup();
  }

  protected setup():void {
    this.setupCamera();
    this.setupRenderer();
    this.setupLights();
    this.setupControl();
    this.initNotify();
    this._setup();
  }

  /**
   * Hook用
   */
  protected _setup():void {

  }

  protected setupCamera():void {
    this.camera = new PerspectiveCamera(75, 600 / 400, .1, 5000);
    this._setupCameraPos();
    this._setupCameraLookAt();

    console.log("this.camera", this.camera);
  }

  protected _setupCameraPos():void {
    this.camera.position.set(400, 1200, 700);
  }

  protected _setupCameraLookAt():void {
    this.camera.lookAt(new THREE.Vector3());
  }

  protected setupRenderer():void {
    if (Modernizr.webgl) {
      //new WebGLRendererParameters
      //TODO: オプションを入れる
      this.renderer = new THREE.WebGLRenderer(null);
      //this.renderer = new THREE.WebGLRenderer(this.option.rendererParams)
    }
    else {
      this.renderer = new THREE.CanvasRenderer();
    }

    window.addEventListener('resize', () => this.onWindowResize());
    this.onWindowResize();

    this._setupClearColor();
    document.getElementById('renderer').appendChild(this.renderer.domElement)

  }

  protected setupLights():void {
    this._setupDirectionalLight();
    this._setupAmbientLight();
  }

  protected setupControl():void {
    this.control = new THREE.TrackballControls(this.camera, this.renderer.domElement);
  }

  protected initNotify():void {
    $('.notify').delay(2000).fadeOut(1000)
  }

  protected onWindowResize(e?:any):void {
    if (this.camera instanceof PerspectiveCamera) {
      (<PerspectiveCamera>this.camera).aspect = window.innerWidth / window.innerHeight;
      (<PerspectiveCamera>this.camera).updateProjectionMatrix();
    }
    this.renderer.setSize(window.innerWidth, window.innerHeight);
  }

  protected _setupClearColor():void {
    //clearColor = this.option?.clear?.color || 0
    //clearAlpha = this.option?.clear?.alpha || 1
    //this.renderer.setClearColor(clearColor, clearAlpha)
    if (this.renderer instanceof WebGLRenderer) {
      (<WebGLRenderer>this.renderer).setClearColor(0, 1);
    }


  }

  protected _setupAmbientLight():void {
    if (this.option && this.option.amibientLight)
      this.scene.add(new THREE.AmbientLight(this.option.amibientLight.color))
  }

  protected _setupDirectionalLight():void {
    this._directionalLight = new THREE.DirectionalLight(0xffffff, 2);
    this._directionalLight.position.set(0, 300, 100);
    this.scene.add(this._directionalLight);
//  #    lightHelper = new THREE.DirectionalLightHelper(this._directionalLight, 50)
//#    this.scene.add(lightHelper);
  }

  public render():void {
    this.renderer.render(this.scene, this.camera);
  }

  public startLoop():void {
    this.update()
  }

  public update():void {
    if (this.control != null) {
      this.control.update();
    }

    this._update();
    this.render();

    requestAnimationFrame( ()=>this.update());
  }

  protected _update():void {

  }
}

