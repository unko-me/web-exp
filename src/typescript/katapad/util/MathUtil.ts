export class MathUtil {
  constructor() {

  }
  public static random(min:number, max:number):number {
    return Math.random() * (max - min) + min;
  }

  public static rad2rot(radian:number):number {
    return radian * 180 / Math.PI
  }

  /**
   * 現在のvalueをtargetMinからtargetMaxの間におさめる
   * Processingのmapとおなじ
  */
  public static map(value:number, valueMin:number, valueMax:number, targetMin:number, targetMax:number):number {
    var ratio = (value - valueMin) / (valueMax - valueMin);
    var result = (targetMax - targetMin) * ratio + targetMin;
    return result;
  }
}

