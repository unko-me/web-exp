import Texture = THREE.Texture;
import GUI = dat.GUI;
import Mesh = THREE.Mesh;
import MeshPhongMaterial = THREE.MeshPhongMaterial;
import {Engine} from "../animation/Engine";
import Vector3 = THREE.Vector3;
import ShaderMaterial = THREE.ShaderMaterial;
import {MathUtil} from "../katapad/util/MathUtil";
export class Money {
  public static get DEF_VALUE():any {
    return this._DEF_VALUE;
  }
  get mesh():THREE.Mesh {
    return this._mesh;
  }
  private gui:GUI;
  private uniforms:any;
  private _mesh:Mesh;
  private static _DEF_VALUE:any = {
    angle: 0,
    angleV: 0.15,
    amp: 24.0,
    freq: 6.0,
    factor: 2.3,
    factorDecay: 0.09,
  };

  private engine:IEngine;

  private rotate:Vector3;





  constructor(private texture:Texture, public params?:any, location?:Vector3, engine?:IEngine) {
    if (!params) {
      this.params = Money._DEF_VALUE;
    }

    if (engine)
      this.engine = engine;
    else
      this.engine = new Engine(location, MathUtil.random(80, 120), MathUtil.random(3,9));

    this.createMesh();
  }

  private createMesh() {
    let material = this.createShader();

    const geometry = new THREE.PlaneBufferGeometry(400, 200, 100, 20);
    this._mesh = new THREE.Mesh(geometry, material);
  };

  private createShader():ShaderMaterial {
    var vert:string = <string>require('../../shader/uneune/money.vert');
    var frag:string = <string>require('../../shader/uneune/money.frag');
    this.uniforms = {
      angle: {type: "f", value: this.params.angle},
      amp: {type: "f", value: this.params.amp},
      freq: {type: "f", value: this.params.freq},
      factor: {type: "f", value: this.params.factor},
      factorDecay: {type: "f", value: this.params.factorDecay},

      texture: {type: "t", value: this.texture}
    };

    var material = new ShaderMaterial({
      uniforms: this.uniforms,
      vertexShader: vert,
      fragmentShader: frag
    });
    material.side = THREE.DoubleSide;
    material.transparent = false;
    material.blending = THREE.NormalBlending;
    return material;
  };

  public update():void {
    if (!this.texture) return;

    this.params.angle += this.params.angleV;
    this.uniforms.angle.value = this.params.angle;
    this.uniforms.amp.value = this.params.amp;
    this.uniforms.freq.value = this.params.freq;
    this.uniforms.factor.value = this.params.factor;
    this.uniforms.factorDecay.value = this.params.factorDecay;
  }

  updateLocation(target:Vector3):void {
    this.engine.seek(target);
    this.engine.update();
    if (!this.mesh)
      return;

    this.mesh.position.copy(this.engine.location);
    //var v = this.engine.velocity.clone();
    var v = this.engine.getVeclocity().clone();
    v.normalize();
    var rad = Math.atan2(v.y, v.x);
    this.mesh.rotation.z += (rad - this.mesh.rotation.z) * 0.4;
  }
}

