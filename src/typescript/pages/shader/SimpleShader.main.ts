import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";
import MeshPhongMaterial = THREE.MeshPhongMaterial;
import Texture = THREE.Texture;
import GUI = dat.GUI;
import {Money} from "../../3dmodel/Money";

export class SimpleShader extends BaseWorld {
  private uniformsPudding:any;

  private params:any = {};
  private texture:Texture;
  private gui:GUI;
  private money:Money;


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
      this._createMoney();
    });

  }

  private _createMoney():void {
    this.params = {
      angle: 0,
      angleV: 0.15,
      amp: 24.0,
      freq: 6.0
    };

    this.gui = new GUI();
    this.gui.add(this.params, 'angleV', 0.01, 2.0);
    this.gui.add(this.params, 'amp', .1, 100);
    this.gui.add(this.params, 'freq', 0.1, 100);

    this.money = new Money(this.texture, this.params);
    this.scene.add(this.money.mesh);
  };

  protected _update():void {
    if (!this.money) return;
    this.money.update();
  }
}


new SimpleShader().startLoop();





