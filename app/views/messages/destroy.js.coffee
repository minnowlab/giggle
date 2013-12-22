$("#message_item_<%= @message.id %>").fadeOut( "fast" )
$('#message_form_alert').removeClass('hidden').addClass('alert-success').text('删除成功。')
$('#message_count_prompt').text('<%= render partial: 'shared/message_count_prompt', locals: { feed_count: @feed_count, messages: @message } %>')
<% if @message.messageable_type == "Product" %>
$('.badge_product').text(<%= @feed_count %>)
<% end %>
