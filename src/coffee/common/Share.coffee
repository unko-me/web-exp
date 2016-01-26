UA = require './../bascule/util/UA'

class Share
  @init: ->
    console.log "[Share] init"
    d = document
    app_id = $("meta[property='fb:app_id']").attr("content")
    $ ->
#      UA = window.tt.UA
      count = 0
      initSns = (id, src)->
        s = 'script'
        if not js = d.getElementById(id)
          fjs = d.getElementsByTagName(s)[0]
          js = d.createElement(s)
          js.id = id
          js.src = src
          fjs.parentNode.insertBefore(js, fjs)
          count++
        return js
      onload = (callback)->
        count--
        if not count then do callback
      load = (callback)->
        twjs = initSns('twitter-wjs', 'https://platform.twitter.com/widgets.js')

        ((d, s, id) ->
          js = undefined
          fjs = d.getElementsByTagName(s)[0]
          if d.getElementById(id)
            return
          js = d.createElement(s)
          js.id = id
          js.src = '//connect.facebook.net/ja_JP/sdk.js#xfbml=1&version=v2.5&appId=' + app_id
          fjs.parentNode.insertBefore js, fjs
          return
        ) document, 'script', 'facebook-jssdk'

#        fbhtml = $('#fbLikeTmpl').html()
#        $('li.facebook').html(fbhtml)

        if callback
          # googlejs.onload = -> onload callback
          twjs.onload = -> onload callback
    #      fbjs.onload = -> onload callback
      if not UA.smartphone
        setTimeout ->
          load ->
            $('.socialBtns').addClass 'complete'
        ,800
      else
        # locker = (event)-> do event.preventDefault
        # window.lock = -> this.addEventListener 'touchmove',locker
        # window.unlock = -> this.removeEventListener 'touchmove',locker
        $socialBtns = $('.socialBtns')
        # $socialBtns.addClass 'complete'
        # setTimeout load,800
        done = false
        onscroll = (event)->
          if done
            return
          windowHeight = if window.innerHeight > 0 then window.innerHeight else screen.height
          scrollTop = document.documentElement.scrollTop or document.body.scrollTop
          scrollBottom = scrollTop + windowHeight
          offsetTop = $socialBtns.offset().top - windowHeight
          console.log 'scrollBottom > offsetTop:', scrollBottom > offsetTop, scrollBottom , offsetTop
          if scrollBottom > offsetTop
            window.removeEventListener 'scroll',onscroll
            done = true
            console.log 'done:', done
            load ->
              $socialBtns.addClass 'complete'
              # device pixel ratio 対応
#              if UA.android and window.devicePixelRatio
#                $('.twitter iframe, .facebook iframe').css({transform: "scale(#{window.devicePixelRatio})"})
        setTimeout ->
          onscroll()
        , 1800
#        window.addEventListener 'scroll', onscroll
        window.addEventListener 'scroll', _.throttle(onscroll, 500)
module.exports = exports = Share