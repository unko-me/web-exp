Consts = require "../../Consts"
TRACK_ID = Consts.analytics.track_id
TRACK_DOMAIN = Consts.analytics.track_domain
GTM_ID = Consts.analytics.GTM_id

class Track
  constructor: () ->

  @init: (isTrackPage = true, detectCode = false)->

    `(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','//www.google-analytics.com/analytics.js','ga');`

    ga "create", TRACK_ID, TRACK_DOMAIN
    if isTrackPage
      @trackPage()

    # Google Tag Manager
    if GTM_ID
      `(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start': new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0], j = d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src= '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f); })(window,document,'script','dataLayer',GTM_ID);`

    if detectCode
      @detectTrackCode()

  @trackPage: (pageName = null)->
    ga "send", "pageview", pageName

  @trackEvent: (category, action, label = null, value = NaN)->
    if label
      if not isNaN(value)
        ga "send", "event", category, action, label, value
      else
        ga "send", "event", category, action, label
    else
      ga "send", "event", category, action

  @trackRawData: (value)->
    list = value.replace(/\s+/g,',').split(',')
    list[0] = list[0]
    @trackEvent.apply(null, list)
    return

  ###
  スクロールイベント時のトラッキング
  ###
  @trackScrollEvent: (action, label = null, value = NaN)->
    @trackEvent 'scroll', action, label, value

  ###
  ボタンクリック時のトラッキング
  ###
  @trackClickEvent: (label = null, value = NaN)->
    @trackEvent 'button', 'click', label, value

  ###

  ###
  @detectTrackCode: =>
    $('.trackClick').each(->
      elem = $(@)
      data = elem.data('track')
      $(@).on('click', ->
        Track.trackRawData(data)
      )
    )


module.exports = exports = Track