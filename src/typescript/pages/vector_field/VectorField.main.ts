import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";
import MeshPhongMaterial = THREE.MeshPhongMaterial;
import Texture = THREE.Texture;
import GUI = dat.GUI;
import {Money} from "../../3dmodel/Money";
import {Stage} from "../../katapad/Stage";
import Vector3 = THREE.Vector3;
import {DOFShader} from "../../shader/dof/DOFShader";
import Mesh = THREE.Mesh;
import MeshBasicMaterial = THREE.MeshBasicMaterial;
import {ArrowPlane} from "./ArrowPlane";
import Object3D = THREE.Object3D;
import {MathUtil} from "../../katapad/util/MathUtil";

const NUM_MONEY = 100;


require('../../../js/lib/three/shaders/DotScreenShader');
require('../../../js/lib/three/shaders/RGBShiftShader');



var ROW:number = 12;
var COL:number = 16;
var MARGIN_W:number = 256;
var MARGIN_H:number = 256;
var CENTER_X:number = MARGIN_W * COL / 2;
var CENTER_Y:number = MARGIN_H * ROW / 2;

export class MoneyMoveMain extends BaseWorld {
  private params:any = {};
  private texture:Texture;
  private gui:GUI;
  private moneys:Array<Money>;
  private ground:Mesh;
  private arrowContainer:Object3D;

  private arrowList:Array<ArrowPlane>;
  private arrowListXY:Array<Array<ArrowPlane>>;


  constructor() {
    super({
      amibientLight: {
        color: 0x666666
      }
    });
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    //this.createGround();
    this.initField();
    var loader = new THREE.TextureLoader();
    loader.load('/img/sozai/1000000-512.jpg', (texture)=> {
      this.texture = texture;
      this._createMoneys(texture);
    });

  }

  private initField():void {

    this.arrowList = [];
    this.arrowListXY = [];
    var tex = THREE.ImageUtils.loadTexture('/img/sozai/arrow128.png');
    //tex.flipY = true;

    this.arrowContainer = new THREE.Object3D();
    this.scene.add(this.arrowContainer);

    var force = new Vector3(1, 1, 0);
    for (var y = 0; y < ROW; y++) {
      var row:Array<ArrowPlane> = [];
      this.arrowListXY[y] = row;
      for (var x = 0; x < COL; x++) {
        var plane = new ArrowPlane(tex);
        this.arrowList.push(plane);
        row.push(plane);
        this.arrowContainer.add(plane);
        plane.position.x = x * MARGIN_W - CENTER_X;
        plane.position.y = y * MARGIN_H - CENTER_Y;
        force.x = 2 * Math.PI / COL * x;
        force.x = Math.sin(x * 0.7) * 1.9 + Math.random();
        force.y = Math.cos(y * 0.7) * 1.9 + Math.random();
        //force.y = 2 * Math.PI / ROW * y;
        //plane.setRotate(2 * Math.PI / col * x + 2 * Math.PI / row * y);
        plane.setForce(force);

      }
    }
  }


  protected _update():void {

    const hasMouseList = Stage.mouseMoveList.length > 0;
    const sHalfW = Stage.width * 0.5;
    const sHalfH = Stage.width * 0.5;
    var target:Vector3 = new Vector3((Stage.clientX - sHalfW) * 2.5, (-Stage.clientY + sHalfH) * 2.5);

    if (this.moneys) {
      var i = 0;
      for (let money of this.moneys) {
        //if (hasMouseList) {
        //  var mouse = Stage.mouseMoveList[i % Stage.mouseMoveList.length];
        //  target = new Vector3((mouse.clientX - sHalfW) * 2.5, (-mouse.clientY + sHalfH) * 2.5);
        //}
        //else {
        //
        //}
        //money.updateLocation(target);

        //console.log("[VectorField.main] money.mesh.position.x", money.mesh.position.x);
        if (this.arrowListXY.length > 0)
          money.applyForce(this.getForce(money.mesh.position));
        money.update();
        i++;
      }
    }



  }


  protected _setupCameraPos():void {
    this.camera.position.set(0, 0, 2500);
  }

  private _createMoneys(texture:THREE.Texture):void {
    this.moneys = [];
    for(let i = 0; i < NUM_MONEY; i++) {
      let params = _.cloneDeep(Money.DEF_VALUE);
      params.freq += Math.random()* 2 - 1 + 9;
      params.angleV += (Math.random() - 0.5) * 0.1 + 0.3;
      params.amp += (Math.random() - 0.5) * 4;
      params.factor += (Math.random() - 0.5) * 1;


      var money = new Money(texture, params);
      this.moneys.push(money);
      this.scene.add(money.mesh);
      money.mesh.position.x = (Math.random() - 0.5) * 1000;
      money.mesh.position.y = (Math.random() - 0.5) * 1000;
      money.mesh.position.z = (Math.random() - 0.5) * 1000;
    }
  }



  private createGround():void {
    const geo = new THREE.PlaneGeometry(4000, 4000, 4);
    this.ground = new Mesh(geo, new MeshBasicMaterial({
      wireframe: true,
      side: THREE.DoubleSide,
      color: 0xffff00,
    }));
    this.scene.add(this.ground);
  }

  private getForce(position:THREE.Vector3):Vector3 {
    var x = Math.floor((position.x - CENTER_X) / MARGIN_W + COL);
    var y = Math.floor((position.y - CENTER_Y) / MARGIN_H + ROW);
    var y2 = MathUtil.clamp(y, 0, ROW - 1);
    var x2 = MathUtil.clamp(x, 0, COL - 1);



    var arrow:ArrowPlane = this.arrowListXY[y2][x2];
    var f = arrow.getForce().clone();
    if (x < 0)
      f.x = 10;
    else if (x > COL)
      f.x = -10;
    if (y < 0)
      f.y = 10;
    else if (y > ROW)
      f.y = -10;

    return f;
  }
}


new MoneyMoveMain().startLoop();


