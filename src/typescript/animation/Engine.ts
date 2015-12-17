import Vector3 = THREE.Vector3;
export class Engine {
  get velocity():THREE.Vector3 {
    return this._velocity;
  }
  public location:Vector3;
  private _velocity:Vector3;
  private acceleration:Vector3;
  public maxforce:number;
  public maxspeed:number;

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

  public seek(target:Vector3) {
    var desired:Vector3 = target.subVectors(target, this.location);
    desired.normalize();
    desired.multiplyScalar(this.maxspeed);
    var steer:Vector3 = desired.clone().sub(this._velocity);
    //steer.limit(this.maxforce);
    if (steer.length() > this.maxforce)
    {
      steer.normalize();
      steer.multiplyScalar(this.maxforce);
    }
    this.applyForce(steer);
  }
}

