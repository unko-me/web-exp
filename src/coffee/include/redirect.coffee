do ->
# ipadはSP用に
#for reg,i in [/(iphone)|(ipod)|(android)/i] when navigator.userAgent.match reg then break
  for reg,i in [/(iphone)|(ipad)|(ipod)|(android)/i] when navigator.userAgent.match reg then break
  t = ['sp','index'][i]
  c = location.pathname.match(/([^\/]+)\.html$/i)?[1] or 'index'
  if c isnt t then location.href = "#{t}.html#{location.search or ''}#{location.hash or ''}"
  return