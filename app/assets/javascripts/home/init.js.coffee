$(document).on 'ready page:load', ->
  ReplyEmbedded.init()
  TextareaLimit.init()
  GoTop.init()

  $('[data-toggle="tooltip"]').tooltip()

  $('.at_textarea').atwho
    at: "@"
    data: "/users.json"
    tpl: "<li data-value='@${name}'>${name} <small>${email}</small></li>"

  $("#evaluate_details").qeditor({})

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("数据正在加载中...")
        $.getScript(url)
    $(window).scroll()
