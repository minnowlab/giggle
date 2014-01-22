class Admin::ProductPicturesController < Admin::BaseController
  before_action :find_product_picture, only: [:show, :destroy, :setting_cover]


  def create
    @product_picture = ProductPicture.new(product_picture_params)
    if @product_picture.save
      flash[:success] = '成功创建产品图片！'
      redirect_to :back
    else
      flash.now[:danger] = '创建产品图片失败，请重新创建！'
      redirect_to :back
    end
  end
 
  def index
    @product_pictures = ProductPicture.search_picture(params)
  end

  def destroy
    @product_picture.destroy
    flash[:success] = '删除成功！'
    redirect_to :back
  end

  private
  
    def find_product_picture
      @product_picture = ProductPicture.find(params[:id])
    end

    def product_picture_params
      params.require(:product_picture).permit(:picture, :product_id)
    end
end
