window.TextareaLimit =
  init: ->
    $('.at_textarea').focus( ->
      if $(@).val() is ''
        $('.help-block').html('发言请遵守社区公约，<span class="notice_text">还可以输入</span><span class="notice_text_length">250</span>字')
    ).blur ->
      if $(@).val() is ''
        $('.help-block').html('<em>不超过250个字</em>')      

    $('.at_textarea').keyup ->
      if $(this).val() is '' 
        $('.new_message_submit').attr('disabled', true)
      else
        $('.new_message_submit').attr('disabled', false)

      iNum = Math.ceil(TextareaLimit.getLength($(@).val())/2)

      if ( iNum <= 250 )
        $('.help-block .notice_text').text('还可以输入')
        $('.help-block .notice_text_length').html( 250 - iNum).css('color','')
      else
        $('.help-block .notice_text').text('已经超过')
        $('.help-block .notice_text_length').html( iNum - 250).css('color','red')
        $('.new_message_submit').attr('disabled', true)

  getLength: (str)->
    String(str).replace(/[^\x00-\xff]/g,'aa').length
