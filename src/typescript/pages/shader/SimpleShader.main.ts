import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";

export class SimpleShader extends BaseWorld {
  private uniformsPudding:any;

  private angle:number = 0;
  private swingVec:THREE.Vector3;
  private swingStrength:number = 0.0;


  constructor() {
    super();
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    //this._setupGround();

    var frag:string = <string>require('../../../shader/purupuru/1.frag');
    var vert:string = <string>require('../../../shader/purupuru/1.vert');
    this.swingVec = new THREE.Vector3(0, 1, 0);
    var swingStrength = 0;
    this.uniformsPudding = {
      frame:{
        type: 'f',// float型
        value: 0.0
      },
      modelHeight:{
        type:"f", // float型
        value: 5
      },
      swingVec: {
        type:"v3", // Vector3型
        value: this.swingVec
      },
      swingStrength: {
        type:"f", // float型
        //value: this.swingStrength
        value: swingStrength
      }
    };

    this.uniformsPudding = THREE.UniformsUtils.merge([THREE.ShaderLib.phong.uniforms, this.uniformsPudding]);

    var shaderMaterialPudding = new THREE.ShaderMaterial({
      uniforms: this.uniformsPudding,
      // シェーダーを割り当てる
      vertexShader: vert,
      //fragmentShader: THREE.ShaderLib.phong.fragmentShader
      fragmentShader: frag
    });


    const geometry = new THREE.BoxGeometry(200, 200, 200);
    //const material:Material = new THREE.MeshPhongMaterial({color: 0xdd3b6f});
    const cube = new THREE.Mesh(geometry, shaderMaterialPudding);
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
  protected _update():void {
    this.angle += 0.01;
    this.swingVec.x = Math.sin(this.angle) * 5.5 + 0.5;
    this.swingVec.y = Math.sin(this.angle) * 0.5 + 0.5;
    this.uniformsPudding.swingVec.value = this.swingVec;
    this.uniformsPudding.swingStrength.value = Math.cos(this.angle) * 2 + 2;


  }
}


new SimpleShader().startLoop();





