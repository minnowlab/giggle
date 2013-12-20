$("#message_item_<%= @message.id %>").fadeOut( "fast" )
$('#message_form_alert').removeClass('hidden').addClass('alert-success').text('删除成功。')
$('#message_count_prompt').text('<%= render partial: 'shared/message_count_prompt', locals: { feed_count: @feed_count, messages: @message } %>')
$('.badge_<%= @message.messageable_type.downcase %>').text(<%= @feed_count %>)
