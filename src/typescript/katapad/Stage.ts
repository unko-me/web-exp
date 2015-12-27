const MAX_MOUSE = 200;

export class Stage {
  private static latestMouse:MouseEvent;
  public static mouseMoveList:Array<MouseEvent>;


  public static get isInit():boolean {
    return this._isInit;
  }
  private static _isInit:boolean = false;


  public static get clientX():number {
    if (Stage.latestMouse)
      return Stage.latestMouse.clientX;
    return 0;
  }
  public static get clientY():number {
    if (Stage.latestMouse)
      return Stage.latestMouse.clientY;
    return 0;
  }

  public static get width():number {
    return window.innerWidth;
  }

  public static get height():number {
    return window.innerHeight;
  }

  static init():void {
    if (Stage._isInit)
      return;
    Stage.mouseMoveList = [];
    window.addEventListener('resize', _.throttle(Stage.resize, 100));
    window.addEventListener('mousemove', _.throttle(Stage.onMouseMove, 16));
    Stage._isInit = true;
  }

  static resize(e:Event):void {

  }

  static onMouseMove(e:MouseEvent):void {
    Stage.latestMouse = e;

    //MouseMoveListに押し込む
    if (Stage.mouseMoveList.length === 0) {
      for (let i = 0; i < MAX_MOUSE; i++) {
        Stage.mouseMoveList.push(e);
      }
    }
    else {
      Stage.mouseMoveList.unshift(e);
    }

    if (Stage.mouseMoveList.length > MAX_MOUSE) {
      Stage.mouseMoveList.splice(MAX_MOUSE)
    }

  }
}

