class StringUtil
  @comma: (num)->
    num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

  @zeroPadding: (num, length)->
    (Array(length).join('0') + num).slice(-length)

module.exports = exports = StringUtil