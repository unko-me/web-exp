webpack            = require("webpack-stream").webpack
BowerWebpackPlugin = require "bower-webpack-plugin"
path               = require "path"


config = require './config'
src = "./#{config.src}/coffee/"
filelist = require "./compile_coffee_files"

#entriesディレクトリに入っているcoffeeをコンパイルする
entryFiles = filelist(src, "entries")
# ↓ こっちみたいに直接指定してもよし。compile対象ファイル "hoge/fuga"といった階層でもOK
#entryFiles = [ "entries/pc", "entries/sp", "entries/top" ]
entries = {
  "vendor": [
    'jquery'
    'three.js'
  ]
}

plugins = [
# bower.jsonにあるパッケージをrequire出来るように
    new BowerWebpackPlugin()

  new webpack.optimize.CommonsChunkPlugin("vendor", "vendor.bundle.js")
# ↓下記では`main`で指定されたファイルが配列の場合読み込めない！
# new webpack.ResolverPlugin(
#   new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin ".bower.json", ["main"]
# )
]
unless config.debug
  plugins.push new webpack.optimize.UglifyJsPlugin()


for file in entryFiles
  entries[file] = "#{src}#{file}.coffee"

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
    extensions: ["", ".js", ".coffee", ".webpack.js", ".web.js"]

# .coffeeをcoffee-loaderに渡すように
# 他にもhtmlやcssを読み込む必要がある場合はここへ追記
  module:
    loaders: [
      { test: /\.jade$/, loader: "jade-loader" }
      {test: /\.coffee$/, loader: "coffee-loader"}
    ]



# webpack用の各プラグイン
  plugins: plugins

