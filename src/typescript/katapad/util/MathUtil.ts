export class MathUtil {
  constructor() {

  }
  public static random(min:number, max:number):number {
    return Math.random() * (max - min) + min;
  }

  public static rad2rot(radian:number):number {
    return radian * 180 / Math.PI
  }
}

