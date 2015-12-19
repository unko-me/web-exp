import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";
import MeshPhongMaterial = THREE.MeshPhongMaterial;
import Texture = THREE.Texture;
import GUI = dat.GUI;
import {Money} from "../../3dmodel/Money";
import {Stage} from "../../katapad/Stage";
import Vector3 = THREE.Vector3;


const NUM_MONEY = 1000;

export class MoneyMoveMain extends BaseWorld {
  private params:any = {};
  private texture:Texture;
  private gui:GUI;
  private money:Money;
  private moneys:Array<Money>;


  constructor() {
    super({
      amibientLight: {
        color: 0x666666
      }
    });
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    var loader = new THREE.TextureLoader();
    loader.load('/img/sozai/1000000-512.jpg', (texture)=> {
      this.texture = texture;
      //this._createMoneys(texture);
      this._createMoney();
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
    var target:Vector3 = new Vector3((Stage.clientX - Stage.width * 0.5) * 2.5, (-Stage.clientY + Stage.height * 0.5) * 2.5);

    //if (!this.moneys) return;
    //for (let money of this.moneys) {
    //  money.updateLocation(target);
    //  money.update();
    //}


    if (this.money) {
      this.money.updateLocation(target);
      this.money.update();
    }
  }


  protected _setupCameraPos():void {
    this.camera.position.set(0, 0, 2000);
  }

  private _createMoneys(texture:THREE.Texture):void {
    this.moneys = [];
    for(let i = 0; i < NUM_MONEY; i++) {
      let params = _.cloneDeep(Money.DEF_VALUE);
      params.freq += Math.random()* 2 - 1;
      params.angleV += (Math.random() - 0.5) * 0.1;
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
}


new MoneyMoveMain().startLoop();


