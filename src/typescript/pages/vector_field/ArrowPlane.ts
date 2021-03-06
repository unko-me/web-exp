//class ArrowPlane extends THREE.Mesh
//  constructor: (imgSrc) ->
//    texture = THREE.ImageUtils.loadTexture(imgSrc);
//    geo = new THREE.PlaneBufferGeometry();
//    mat = new THREE.MeshLambertMaterial(texture);
//    super(geo, mat)
//
//
//module.exports = exports = ArrowPlane


import MeshLambertMaterial = THREE.MeshLambertMaterial;
import Mesh = THREE.Mesh;
import PlaneGeometry = THREE.PlaneGeometry;

export class ArrowPlane extends Mesh {
  private force;
  constructor(tex) {
    var geo = new PlaneGeometry(256, 256);
    var mat = new MeshLambertMaterial({
      map: tex,
      transparent: true,
      side: THREE.DoubleSide
    });
    super(geo, mat);
  }

  public setRotate(redian:number):void {
    this.rotateZ(redian);

  }

  setForce(force:THREE.Vector3):void {
    var radian = Math.atan2(force.y, force.x);
    this.force = force.clone();
    this.rotateZ(radian);
  }

  getForce():THREE.Vector3 {
    return this.force;
  }
}

