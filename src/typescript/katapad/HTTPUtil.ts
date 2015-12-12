export class HTTPUtil {
  constructor() {

  }
  public static getUrlVars():Object {
    const params:Array = location.search.substring(1).split('&');
    let vars = {};
    let i:number = 0;
    const reg = new RegExp('=');
    while (i < params.length) {
      var keySearch = params[i].search(reg);
      var key:string = '';
      if (keySearch != -1) {
        key = params[i].slice(0, keySearch);
      }
      var val = params[i].slice(params[i].indexOf('=', 0) + 1)
      if (key != '')
        vars[key] = decodeURI(val);
      i++
    }
    return vars;
  }
}

