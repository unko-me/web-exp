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

const NUM_MONEY = 10;

require('../../../js/lib/three/shaders/DotScreenShader');
require('../../../js/lib/three/shaders/RGBShiftShader');

export class MoneyMoveMain extends BaseWorld {
  private params:any = {};
  private texture:Texture;
  private gui:GUI;
  private money:Money;
  private moneys:Array<Money>;
  private ground:Mesh;


  constructor() {
    super({
      usePostFx: true,
      amibientLight: {
        color: 0x666666
      }
    });
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    //this.createGround();
    var loader = new THREE.TextureLoader();
    loader.load('/img/sozai/1000000-512.jpg', (texture)=> {
      this.texture = texture;
      this._createMoneys(texture);
      //this._createMoney();
    });

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


  protected addPostFx():void {
    //var effect = new THREE.ShaderPass( (<any>THREE).DotScreenShader );
    //effect.uniforms[ 'scale' ].value = 4;
    //effect.renderToScreen = true;
    //this.composer.addPass( effect );
    //
    var effect = new THREE.ShaderPass( (<any>THREE).RGBShiftShader );
    effect.uniforms[ 'amount' ].value = 0.0015;
    effect.renderToScreen = true;
    this.composer.addPass( effect );
    //var effect = new THREE.ShaderPass( new DOFShader() );
    //effect.renderToScreen = true;
    //this.composer.addPass( effect );
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


