class Admin::ProductPicturesController < Admin::BaseController
  before_action :find_product_picture, only: [:show, :destroy, :setting_cover]
 
  def index
    @product_pictures = ProductPicture.page(params[:page])
  end

  def destroy
    @product_picture.destroy
    flash[:success] = '删除成功！'
    redirect_to :back
  end

  def setting_cover
    @no_cover_product_pictures = ProductPicture.where(product_id: @product_picture.product_id)
    @no_cover_product_pictures.update_all(cover: false)
    @product_picture.update(cover: true)
    flash[:success] = '设置成功成功！'
    redirect_to :back
  end

  private
  
    def find_product_picture
      @product_picture = ProductPicture.find(params[:id])
    end
end
