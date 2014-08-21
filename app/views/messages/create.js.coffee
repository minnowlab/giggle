<% if @message.errors.empty? %>
  $('#message_form_alert').removeClass('hidden').addClass('alert-success').text('回复成功。')
  $('<%= j(render partial: 'message', object: @message) %>').appendTo($('#all_messages'))
  $('#message_content').val("")
  $('#message_count_prompt').text('<%= render partial: 'shared/message_count_prompt', locals: { message_count: @message_count, messages: @message } %>')
  <% if @message.messageable_type == "Product" %>
  $('.badge_product').text(<%= @message_count %>)
  <% end %>
<% else %>
  $('#message_form_alert').removeClass('hidden').addClass('alert-danger').text('<%= @message.errors.full_messages.join(',') %>')
<% end %>
