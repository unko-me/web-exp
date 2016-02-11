import {BaseWorld} from "../../core/BaseWorld";
import {PageDetailUtil} from "../../core/PageDetailUtil";
import CubeGeometry = THREE.CubeGeometry;
import MeshLambertMaterial = THREE.MeshLambertMaterial;
import Mesh = THREE.Mesh;
import {Stage} from "../../katapad/Stage";
import OrthographicCamera = THREE.OrthographicCamera;
export class Fractal1 extends BaseWorld {

  private list:Array<Mesh>;

  constructor() {
    super({
      amibientLight: {
        color: 0x666666
      }
    });
    PageDetailUtil.setPageData({title: "Fractal"})
  }

  protected setupCamera():void {
    this.camera = new OrthographicCamera(-Stage.width / 2, Stage.width / 2, -Stage.height / 2, Stage.height / 2, .1, 100000);

    //this._setupCameraPos();
    this.camera.position.set(0, 0, -100);

    this._setupCameraLookAt();


  }

  protected _setup():void {
    this.list = [];
    this._drawCube(0, 0, 0, 1000);
    this._directionalLight.position.set(3000, 1000, -1000);

    var tl = new TimelineMax({onComplete: ()=> this.chikachika()});
    tl.to(this.camera.position, 3.0, {z: 700, ease: Linear.easeNone, delay: 1.0});
    tl.to(this.camera.position, 1.8, {x: 1000, y: 1000, ease: Expo.easeInOut, delay: 0.0});

  }

  private chikachika():void {
    setTimeout(()=> {
      for (var mesh of this.list) {
        (<MeshLambertMaterial>mesh.material).color = new THREE.Color(Math.random() * 0xFFFFFF);
        (<MeshLambertMaterial>mesh.material).needsUpdate = true;
      }
      this.chikachika();
    }, 60);
  }

  private _drawCube(x:number, y:number, z:number, radius:number):void {
    var cube:CubeGeometry = new CubeGeometry(radius, radius, 10);
    var mat:MeshLambertMaterial = new MeshLambertMaterial({
      color: 0xffffff * Math.random()
    });
    var mesh = new Mesh(cube, mat);
    this.scene.add(mesh);

    mesh.position.x = x;
    mesh.position.y = y;
    mesh.position.z = z;

    this.list.push(mesh);

    if (radius > 10)
      this._drawCube(x, y, z + 10, radius *= 0.9);

  }
}

new Fractal1().startLoop();
