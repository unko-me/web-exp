import Vector3 = THREE.Vector3;
export class Engine {
  public location:Vector3;
  private velocity:Vector3;
  private acceleration:Vector3;
  public maxforce:number;
  public maxspeed:number;

  constructor(location?:Vector3) {
    if (location)
      this.location = location.clone();
    else
      this.location = new Vector3();
    this.velocity = new Vector3();
    this.acceleration = new Vector3();

    this.maxforce = 20;
    this.maxforce = 1;
  }

  public update():void {
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    this.acceleration.multiplyScalar(0);

  }

  public applyForce(force:Vector3):void {
    this.acceleration.add(force);
  }
}

