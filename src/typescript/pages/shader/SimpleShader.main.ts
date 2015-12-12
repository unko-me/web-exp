import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";

export class SimpleShader extends BaseWorld {
  constructor() {
    super();
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    //this._setupGround();

    var frag:string = <string>require('../../../shader/purupuru/1.frag');
    var vert:string = <string>require('../../../shader/purupuru/1.frag');

    const geometry = new THREE.BoxGeometry(200, 200, 200);
    const material:Material = new THREE.MeshPhongMaterial({color: 0xdd3b6f});
    const cube = new THREE.Mesh(geometry, material);
    this.scene.add(cube);

  }

  private _setupGround():void {
    const material = new THREE.MeshLambertMaterial({
      color: 0x333333b
      //wireframe: true
    });
    const geometry = new THREE.PlaneGeometry(6000, 6000, 10, 10);
    const mesh = new THREE.Mesh(geometry, material);
    this.scene.add(mesh);

    mesh.rotation.x = -90 * Math.PI / 180;
  }

}


new SimpleShader().startLoop();





