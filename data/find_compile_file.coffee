fs = require "fs"
path = require "path"
glob = require "glob"

#d = './src/coffee/entries/'

searchFile = (src, targetDir)=>
  files = fs.readdirSync(path.join(src, targetDir))
  reg = new RegExp(/\.coffee$/)
  list = files.map((file)->
    if reg.test(file)
      return file.replace(/\.coffee$/, '')
    return null
  ).filter((file)->
    return file
  ).map((file)->
    return path.join(targetDir, file)
  )

  return list


searchScripts = (baseDir, pattern) ->
  files = glob.sync path.join(baseDir, pattern)
  fileList = {}

  baseDirPattern = baseDir.replace(/\.\//, '')
  reg = new RegExp(baseDirPattern)
  for file in files
    basename = file.replace(path.extname(file), '')
    basename = basename.replace(reg, '')
    fileList[basename] = path.resolve('./', file)
  return fileList


module.exports = exports = {searchFile, searchScripts}


#searchScripts('./src/{coffee,typescript}', '/entries/**/*.{coffee,ts}')
#searchScripts('./src/{coffee,typescript}', '/**/*.main.{coffee,ts}')
#console.log searchScripts('./src/coffee/', 'entries/**/*.coffee')
#console.log searchScripts('./src/coffee/', '**/*.main.coffee')