import {HTTPUtil} from "../katapad/util/HTTPUtil";
export class DynamicLoadPage
{
  constructor()
  {
    //var vars:Object = HTTPUtil.getUrlVars();
    //if (!vars['js']) {
    //  alert("jsのソース指定がありませんです");
    //  return;
    //}

    var src = document.location.hash.replace(/^#/, '');
    console.log("[DynamicLoadPage.main] src", src);

    const script = document.createElement('script');
    script.src = `/js/${src}`;
    document.head.appendChild(script);
  }
}

new DynamicLoadPage();