window.PreviewMarkdown =
  init: ()->
    $('.edit').click ->
      $(@).addClass('btn-primary')
      $('.preview').removeClass('btn-primary')
      $('#preview').addClass('hidden')
      $('#evaluate_details').removeClass('hidden')
      false

    $('.preview').click ->
      $.post( 
        '/products/preview_markdown'
        {body: $('#evaluate_details').val()}
        (data)->
          $('.preview').addClass('btn-primary')
          $('.edit').removeClass('btn-primary')
          $('#evaluate_details').addClass('hidden')
          $('#preview').removeClass('hidden')
          $('#preview').html(data)
          false
      )
      false

$ ->
  PreviewMarkdown.init()
