import {Engine} from "./Engine";
import {MathUtil} from "../katapad/util/MathUtil";
import Vector3 = THREE.Vector3;

export class ArriveEngine extends Engine {
  constructor(location?:Vector3, maxspeed:number = 20, maxforce:number = 3) {
    super(location, maxspeed, maxforce);
  }

  public seek(target:Vector3):void {
    target = target.clone();
    var desired:Vector3 = target.subVectors(target, this.location);
    var diff = desired.length();

    desired.normalize();
    //到着行動
    if (diff < 500) {
      var m = MathUtil.map(diff, 0, 500, 0, this.maxspeed);
      desired.multiplyScalar(m);
    }
    else {
      desired.multiplyScalar(this.maxspeed);
    }

    var steer:Vector3 = desired.clone().sub(this._velocity);
    if (steer.length() > this.maxforce)
    {
      steer.normalize();
      steer.multiplyScalar(this.maxforce);
    }
    this.applyForce(steer);
  }
}

