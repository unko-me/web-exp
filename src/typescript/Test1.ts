export class Test1 {
  get prop1():string {
    return this._prop1;
  }
  private _prop1:string;
  constructor(public prop:string) {
    this._prop1 = "hogehoge";

  }

  say():void {
    console.log(this.prop);
  }
}

