import {HTTPUtil} from "../katapad/util/HTTPUtil";
export class DynamicLoadPage
{
  constructor()
  {
    var vars:Object = HTTPUtil.getUrlVars();
    if (!vars['js']) {
      alert("jsのソース指定がありませんです");
      return;
    }

    const script = document.createElement('script');
    script.src = `/js/${vars["js"]}`;
    document.head.appendChild(script);
  }
}

new DynamicLoadPage();