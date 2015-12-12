export class PageDetailUtil {
  constructor() {

  }

  public static setPageData(options:any):void {
    if (!!options['title']) {
      window.document.title = `${options['title']} | ${window.document.title}`
    }
  }
}


