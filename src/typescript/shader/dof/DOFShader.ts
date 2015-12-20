import ShaderMaterial = THREE.ShaderMaterial;
export class DOFShader extends ShaderMaterial {
  public params:any;
  constructor() {
    this.params = {
      angle: 0.0
    };
    var vert:string = <string>require('../../../shader/dof/UsoDOF.vert');
    var frag:string = <string>require('../../../shader/dof/UsoDOF.frag');

    this.uniforms = {
      tDiffuse: {type: "t", value: null},
      v:        { type: "f", value: 1.2 / 512.0 },
      r:        { type: "f", value: 0.35 },
      whole:    { type: "f", value: 0.0 }
    };


    super({
      uniforms: this.uniforms,
      vertexShader: vert,
      fragmentShader: frag
    });

    this.side = THREE.DoubleSide;
    this.transparent = false;
    this.blending = THREE.NormalBlending;



    var gui = new dat.GUI();
    console.log("[DOFShader] this.uniforms", this.uniforms);
    gui.add(this.uniforms.whole, 'value', 0, 1);
  }
}

