fs = require "fs"
path = require "path"

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

module.exports = exports = searchFile

#console.log searchFile('./src/coffee/', 'entries')


