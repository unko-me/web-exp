Test1 = require '../test_code/Test1'

console.log 'test.coffeeです'

new Test1()

# アニメーション研究
$ ->
  $('.test1 > div').each( (i, elem)->
    $(@).velocity({opacity: 0}, {duration: 0})
    .velocity({opacity: 1}, {duration: 500, delay: i * 200})
  )
  $('.test2 > div').each( (i, elem)->
    $(@).velocity({opacity: 0, translateY: 20}, {duration: 0})
    .velocity({opacity: 1, translateY: 0}, {duration: 600, easing: "easeOutQuint", delay: i * 100})
  )

  do ->
    list = [0...$('.test3 > div').length]
    list = _.shuffle(list)
    $('.test3 > div').each( (i, elem)->
      $(@).velocity({opacity: 1, translateY: 120}, {duration: 0})
      .velocity({opacity: 1, translateY: 0}, {duration: 300, easing: "easeOutQuint", delay: list[i] * 100})
    )


  do ->
    TweenMax.staggerFromTo('.test4 > div', 0.2, {opacity: 0, y: 30}, {opacity: 1, y: 0}, 0.2)
    TweenMax.staggerFromTo('.test5 > div', 0.2, {opacity: 0, y: 30, rotation: -40}, {rotation: 0, opacity: 1, y: 0}, 0.06)
    TweenMax.staggerFromTo('.test6 > div', 0.9, {opacity: 0, x: 200, y: 30}, {opacity: 1, bezier: {values: [{x: 100, y: 100}, {x: 0, y: 0}]}}, 0.06)
#    TweenMax.staggerFromTo('.test6 > div', 0.9, {opacity: 0, x: 200, y: 30}, {opacity: 1, bezier: {values: [{x: 100, y: 100}, {x: 0, y: 0}], autoRotate: true}}, 0.06)



