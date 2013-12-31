class UserPicturesController < ApplicationController
  load_and_authorize_resource only: [:create, :destroy]
  before_action :find_user
  layout "user"

  def index
    @user_pictures = @user.user_pictures
    @user_picture = UserPicture.new
  end

  def create
    @user_picture = @user.user_pictures.build(user_picture_params)
    if @user_picture.save
      flash[:success] = '上传成功！'
      redirect_to :back
    else
      flash[:danger] = '上传失败，请重新上传！'
      redirect_to :back
    end
  end

  def destroy
    @user_picture = @user.user_pictures.find(params[:id])
    @user_picture.destroy
    flash[:success] = '删除成功！'
    redirect_to :back
  end

  private
    def find_user
      @user = current_user
    end
    
    def user_picture_params
      params.require(:user_picture).permit(:picture)
    end

end
