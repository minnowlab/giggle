<% if @error_msg.nil? %>
  $('#sign_in_modal').modal('hide')
  $('.navigation').empty()
  $('<%= j(render "layouts/navbar/success_sign_in_navbar") %>').appendTo($('.navigation'))
  $('.sign_in_notice').remove()
  $('#new_message .new_message_input').attr("disabled", false)
<% else %>
  $('#sign_in_alert').text('<%= @error_msg %>').removeClass('hidden')
  $('#password').val('')
<% end %>
