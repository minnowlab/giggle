window.ReplyEmbedded =
  init: ()->
    $( ".reply" ).click ->
      user_name = $(this).data('name')
      $(".at_textarea").val ( i, val )->
        "#{val} @#{user_name} "
