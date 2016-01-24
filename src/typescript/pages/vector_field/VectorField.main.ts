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

const NUM_MONEY = 1;

require('../../../js/lib/three/shaders/DotScreenShader');
require('../../../js/lib/three/shaders/RGBShiftShader');

export class MoneyMoveMain extends BaseWorld {
  private params:any = {};
  private texture:Texture;
  private gui:GUI;
  private money:Money;
  private moneys:Array<Money>;
  private ground:Mesh;
  private arrowContainer:Object3D;

  private arrowList:Array<ArrowPlane>;

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
      //this._createMoney();
    });

  }

  private initField():void {
    var row = 12;
    var col = 16;
    var marginW = 256;
    var marginH = 256;
    var centerX = marginW * col / 2;
    var centerY = marginH * row / 2;

    this.arrowList = [];
    var tex = THREE.ImageUtils.loadTexture('/img/sozai/arrow128.png');
    //tex.flipY = true;

    this.arrowContainer = new THREE.Object3D();
    this.scene.add(this.arrowContainer);

    var force = new Vector3(1, 1, 0);
    for (var y = 0; y < row; y++) {
      for (var x = 0; x < col; x++) {
        var plane = new ArrowPlane(tex);
        this.arrowList.push(plane);
        this.arrowContainer.add(plane);
        plane.position.x = x * marginW - centerX;
        plane.position.y = y * marginH - centerY;
        //plane.setRotate(2 * Math.PI / col * x + 2 * Math.PI / row * y);
        plane.setForce(force);
      }
    }
  }

  private _createMoney():void {
    this.params = Money.DEF_VALUE;

    this.gui = new GUI();
    this.gui.add(this.params, 'angleV', 0.01, 2.0);
    this.gui.add(this.params, 'amp', .1, 100);
    this.gui.add(this.params, 'freq', 0.1, 100);
    this.gui.add(this.params, 'factor', -5, 50);
    this.gui.add(this.params, 'factorDecay', -2, 2);

    this.money = new Money(this.texture, this.params);
    this.scene.add(this.money.mesh);
  };

  protected _update():void {

    const hasMouseList = Stage.mouseMoveList.length > 0;
    const sHalfW = Stage.width * 0.5;
    const sHalfH = Stage.width * 0.5;
    var target:Vector3 = new Vector3((Stage.clientX - sHalfW) * 2.5, (-Stage.clientY + sHalfH) * 2.5);

    if (this.moneys) {
      var i = 0;
      for (let money of this.moneys) {
        if (hasMouseList) {
          var mouse = Stage.mouseMoveList[i % Stage.mouseMoveList.length];
          target = new Vector3((mouse.clientX - sHalfW) * 2.5, (-mouse.clientY + sHalfH) * 2.5);
        }
        else {

        }
        money.updateLocation(target);
        money.update();
        i++;
      }
    }



    if (this.money) {
      this.money.updateLocation(target);
      this.money.update();
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
}


new MoneyMoveMain().startLoop();


