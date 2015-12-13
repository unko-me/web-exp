import {BaseWorld} from "../../core/BaseWorld";
import Material = THREE.Material;
import {PageDetailUtil} from "../../core/PageDetailUtil";
import MeshPhongMaterial = THREE.MeshPhongMaterial;
import Texture = THREE.Texture;

export class SimpleShader extends BaseWorld {
  private uniformsPudding:any;

  private angle:number = 0;
  private swingVec:THREE.Vector3;
  private swingStrength:number = 0.0;
  private texture:Texture;


  constructor() {
    super({
      amibientLight: {
        color: 0x666666
      }
    });
    PageDetailUtil.setPageData({title: "HTMLすら作らないタイプのページ"})
  }
  protected _setup():void {
    //this._setupGround();
    this.texture = THREE.ImageUtils.loadTexture('/img/sozai/1000000-512.jpg', THREE.UVMapping);

    var frag:string = <string>require('../../../shader/uneune/money.frag');
    var vert:string = <string>require('../../../shader/uneune/money.vert');
    this.swingVec = new THREE.Vector3(0, 1, 0);
    var swingStrength = 0;
    this.uniformsPudding = {
      texture: {
        type:"t",
        value: this.texture
      }
    };

    this.uniformsPudding = THREE.UniformsUtils.merge([THREE.ShaderLib.phong.uniforms, this.uniformsPudding]);

    var shaderMaterialPudding = new THREE.ShaderMaterial({
      uniforms: this.uniformsPudding,
      vertexShader: vert,
      fragmentShader: frag
    });
    shaderMaterialPudding.side = THREE.DoubleSide;
    shaderMaterialPudding.transparent = false;
    shaderMaterialPudding.blending = THREE.NormalBlending;


    var mat = new MeshPhongMaterial({
      map: this.texture
    });


    const geometry = new THREE.PlaneBufferGeometry(400, 200);
    //const cube = new THREE.Mesh(geometry, shaderMaterialPudding);
    const cube = new THREE.Mesh(geometry, mat);
    this.scene.add(cube);
    mat.side = THREE.DoubleSide;
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
    //this.swingVec.x = Math.sin(this.angle) * 5.5 + 0.5;
    //this.swingVec.y = Math.sin(this.angle) * 0.5 + 0.5;
    //this.uniformsPudding.swingVec.value = this.swingVec;
    //this.uniformsPudding.swingStrength.value = Math.cos(this.angle) * 2 + 2;


  }
}


new SimpleShader().startLoop();





