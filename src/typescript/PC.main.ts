/// <reference path="tsd.d.ts" />
/// <reference path="typings/local.d.ts" />
/// <reference path="common.ts" />

import {Test1} from "./Test1";
import {BaseWorld} from "./core/BaseWorld";

var perlin:any = require('../js/lib/perlin.js');
console.log("perlin", perlin.noise.simplex2(10, 20));


class PC {
  constructor() {
    console.log("-------------------ここからTypeScript");
    console.log("PC Main TypeScriptファイルです");
    new Test1("テストクラスのプロパティです").say();

    var baseWorld:BaseWorld = new BaseWorld(null);

  }
}

new PC();
