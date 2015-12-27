import Vector3 = THREE.Vector3;
interface IEngine {

  location:Vector3;
  //velocity:Vector3;
  getVeclocity():Vector3;

  update():void;
  applyForce(force:Vector3):void;
  seek(target:Vector3):void;
}