webpack = require("webpack-stream").webpack
BowerWebpackPlugin = require "bower-webpack-plugin"
path = require "path"
_ = require 'lodash'

config = require './config'
{searchFile, searchScripts} = require "./find_compile_file"

entries = {}

#entriesディレクトリに入っているcoffeeをコンパイルする
_.merge entries, searchScripts("#{config.src}/coffee/", "entries/**/*.coffee")
_.merge entries, searchScripts("#{config.src}/typescript/", "entries/**/*.ts")
_.merge entries, searchScripts("#{config.src}/typescript/", "**/*.main.ts")

# ↓ こっちみたいに直接指定してもよし。compile対象ファイル "hoge/fuga"といった階層でもOK
#entryFiles = [ "entries/pc", "entries/sp", "entries/top" ]
#_.merge entries,
#  "vendor": [
#    'jquery'
#    'three.js'
#    'pixi.js'
#    'stats.js'
#    'gsap'
#    'eventemitter2'
#  ]


plugins = [
# bower.jsonにあるパッケージをrequire出来るように
  new BowerWebpackPlugin()

#  new webpack.optimize.CommonsChunkPlugin("vendor", "vendor.bundle.js")

# ↓下記では`main`で指定されたファイルが配列の場合読み込めない！
# new webpack.ResolverPlugin(
#   new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin ".bower.json", ["main"]
# )
]
unless config.debug
  plugins.push new webpack.optimize.UglifyJsPlugin()


module.exports =

  entry: entries

  output:
    filename: "[name].js"

  cache: config.isWatching
  watch: config.isWatching
  debug: config.debug
# @see https://webpack.github.io/docs/configuration.html#devtool
# dev時はevalが速い。
  devtool: if config.isWatching then 'eval' else null

# ファイル名の解決を設定
  resolve:
    root: [path.join(__dirname, "bower_components")]
    moduleDirectories: ["bower_components"]
    extensions: ["", ".js", ".ts", ".coffee", ".webpack.js", ".web.js"]

# .coffeeをcoffee-loaderに渡すように
# 他にもhtmlやcssを読み込む必要がある場合はここへ追記
  module:
    loaders: [
      {test: /\.jade$/, exclude: [/bower_components/, /node_modules/], loader: "jade-loader"}
      {test: /\.coffee$/, exclude: [/bower_components/, /node_modules/], loader: "coffee-loader"}
      {test: /\.ts$/, exclude: [/bower_components/, /node_modules/], loader: 'ts-loader'}
      { test: /\.(glsl|vs|fs|vert|frag)$/, loader: 'shader' }
    ]
#  glsl: {
#    # chunks folder, chunkpath by default is ""
##    chunkPath: __dirname+"/glsl/chunks"
#  }


# webpack用の各プラグイン
  plugins: plugins

