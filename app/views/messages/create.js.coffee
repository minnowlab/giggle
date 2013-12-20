<% if @message.errors.empty? %>
  $('#message_form_alert').removeClass('hidden').addClass('alert-success').text('回复成功。')
  $('<%= j(render partial: 'message', object: @message) %>').appendTo($('#all_messages'))
  $('#message_content').val("")
  $('#message_count_prompt').text('<%= render partial: 'shared/message_count_prompt', locals: { feed_count: @feed_count, messages: @message } %>')
  $('.badge_<%= @message.messageable_type.downcase %>').text(<%= @feed_count %>)
<% else %>
  $('#message_form_alert').removeClass('hidden').addClass('alert-danger').text('<%= @message.errors.full_messages.join(',') %>')
<% end %>
