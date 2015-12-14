import Texture = THREE.Texture;
import GUI = dat.GUI;
import Mesh = THREE.Mesh;
import MeshPhongMaterial = THREE.MeshPhongMaterial;
export class Money {
  public static get DEF_VALUE():any {
    return this._DEF_VALUE;
  }
  get mesh():THREE.Mesh {
    return this._mesh;
  }
  private gui:GUI;
  private uniformsPudding:any;
  private _mesh:Mesh;
  private static _DEF_VALUE:any = {
    angle: 0,
    angleV: 0.15,
    amp: 24.0,
    freq: 6.0,
    factor: 2.3,
    factorDecay: 0.09,
  };

  constructor(private texture:Texture, public params?:any) {
    if (!params) {
      this.params = Money._DEF_VALUE;
    }

    var vert:string = <string>require('../../shader/uneune/money.vert');
    var frag:string = <string>require('../../shader/uneune/money.frag');
    this.uniformsPudding = {
      angle: {type: "f", value: this.params.angle},
      amp: {type: "f", value: this.params.amp},
      freq: {type: "f", value: this.params.freq},
      factor: {type: "f", value: this.params.factor},
      factorDecay: {type: "f", value: this.params.factorDecay},

      texture: {type: "t", value: this.texture}
    };

    var shaderMaterialPudding = new THREE.ShaderMaterial({
      uniforms: this.uniformsPudding,
      vertexShader: vert,
      fragmentShader: frag
    });
    shaderMaterialPudding.side = THREE.DoubleSide;
    shaderMaterialPudding.transparent = false;
    shaderMaterialPudding.blending = THREE.NormalBlending;

    const geometry = new THREE.PlaneBufferGeometry(400, 200, 100, 20);
    this._mesh = new THREE.Mesh(geometry, shaderMaterialPudding);
  }

  public update():void {
    if (!this.texture) return;

    this.params.angle += this.params.angleV;
    this.uniformsPudding.angle.value = this.params.angle;
    this.uniformsPudding.amp.value = this.params.amp;
    this.uniformsPudding.freq.value = this.params.freq;
    this.uniformsPudding.factor.value = this.params.factor;
    this.uniformsPudding.factorDecay.value = this.params.factorDecay;

  }
}

