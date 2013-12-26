module ProductsHelper
  def product_collection_tag product
    return "" if current_user.blank?
    class_name = "icon_mark_select"
    link_title = "收藏"
    link_path_method = "post"
    if current_user and current_user.collectionship_product_ids.include?(product.id)
      class_name = "icon_mark_selected"
      link_title = "取消收藏"
      link_path_method = "delete"
    end
    link_to fa_icon("bookmark"), product_collectionship_path(product), class: class_name, "data-toggle"=>"tooltip", title: link_title, method: link_path_method, remote: true
  end    
end
