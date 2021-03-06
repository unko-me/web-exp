import Vector3 = THREE.Vector3;
import {MathUtil} from "../katapad/util/MathUtil";
export class Engine implements IEngine {
  get velocity():Vector3 {
    return this._velocity;
  }
  public location:Vector3;
  protected _velocity:Vector3;
  protected acceleration:Vector3;
  public maxforce:number;
  public maxspeed:number;
  public getVeclocity():Vector3 {
    return this._velocity;
  }

  constructor(location?:Vector3, maxspeed:number = 20, maxforce:number = 3) {
    this.location = new Vector3();
    if (location)
      this.location.copy(location);
    this._velocity = new Vector3();
    this.acceleration = new Vector3();

    this.maxspeed = maxspeed;
    this.maxforce = maxforce;
  }

  public update():void {
    this._velocity.add(this.acceleration);
    this.location.add(this._velocity);
    this.acceleration.multiplyScalar(0);
  }

  public applyForce(force:Vector3):void {
    this.acceleration.add(force);
  }

  public seek(target:Vector3):void {
    target = target.clone();
    var desired:Vector3 = target.subVectors(target, this.location);
    var diff = desired.length();

    desired.normalize();
    desired.multiplyScalar(this.maxspeed);

    var steer:Vector3 = desired.clone().sub(this._velocity);
    if (steer.length() > this.maxforce)
    {
      steer.normalize();
      steer.multiplyScalar(this.maxforce);
    }
    this.applyForce(steer);
  }
}

