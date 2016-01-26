export class MathUtil {
  constructor() {

  }

  /**
   * 範囲内での乱数を生成します。value 2なら　-2～2を返します。
   * @param	value 2なら　-2～2を返します。
   * @return 	範囲内の乱数
   */
  public static random(min:number, max:number):number {
    return Math.random() * (max - min) + min;
  }

  /**
   * ラジアン → 度 の変換
   * @param	degree
   */
  public static radianToDegree(radian:number):number {
    return radian * 180 / Math.PI
  }

  /**
   * 度→ラジアン の変換
   * @param	degree
   */
  public static degreeToRadian(degree:number):number {
    return degree * Math.PI / 180
  }

  /**
   * ランダムで1か-1を返します
   * */
  public static getCoin():number {
    if (Math.random() > .5)
      return 1;
    else
      return -1;
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

  public static clamp(value:number, min:number, max:number):number {
    return Math.min(Math.max(value, min), max);
  }
}

