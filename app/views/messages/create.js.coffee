<% if @message.errors.empty? %>
  $('<%= j(render :partial => 'message', :object => @message) %>').appendTo($('#all_messages'));
  $('#message_content').val("");
<% else %>
  alert("<%= @message.errors.full_messages.join(',') %>");
<% end %>
