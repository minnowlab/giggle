window.GoTop =
  init: ->
    $("a.go_top").click ->
      $('html, body').animate({ scrollTop: 0 }, 300)
      false

    $(window).bind 'scroll resize', ->
      scroll_from_top = $(window).scrollTop()
      if scroll_from_top >= 1
        $("a.go_top").show()
      else
        $("a.go_top").hide()
