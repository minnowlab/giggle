$('#like_link').empty().append("<%= j(likeable_likes_tag @likeable) %>")
$('[data-toggle="tooltip"]').tooltip()
