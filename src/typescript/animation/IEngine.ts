import Vector3 = THREE.Vector3;
interface IEngine {
  update():void;
  applyForce(force:Vector3):void;
  seek(target:Vector3):void;

}