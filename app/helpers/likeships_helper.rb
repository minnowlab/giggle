module LikeshipsHelper
  def likeable_likes_tag like
    @like = Object.const_get(like[:likeable_type]).where(id: like[:likeable_id]).first
    return "#{fa_icon('heart')} #{@like.likeships.count}人喜欢".html_safe if current_user.blank?
    class_name = "icon_like_select"
    link_title = "喜欢"
    link_path_method = "post"
    if current_user and current_user.liking?(like)
      class_name = "icon_like_selected"
      link_title = "取消喜欢"
      link_path_method = "delete"
    end
    link_to "#{fa_icon('heart')} #{@like.likeships.count}人喜欢".html_safe, likeship_path(like), class: class_name, "data-toggle"=>"tooltip", title: link_title, method: link_path_method, remote: true
  end
end
