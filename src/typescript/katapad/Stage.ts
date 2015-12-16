export class Stage {
  public static get isInit():boolean {
    return this._isInit;
  }
  private static _isInit:boolean = false;
  private static latestMouse:MouseEvent;
  public static get clientX():number {
    if (Stage.latestMouse && Stage.latestMouse.clientX)
      return Stage.latestMouse.clientX;
    return 0;
  }
  public static get clientY():number {
    if (Stage.latestMouse.clientY)
      return Stage.latestMouse.clientY;
    return 0;
  }
  static init():void {
    if (Stage._isInit)
      return;
    Stage._isInit = true;
    window.addEventListener('resize', _.throttle(Stage.resize, 100));
    window.addEventListener('mousemove', _.throttle(Stage.onMouseMove, 16));
  }

  static resize(e:Event):void {

  }
  static onMouseMove(e:MouseEvent):void {
    Stage.latestMouse = e;
  }
}

