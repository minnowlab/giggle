class UserPicturesController < ApplicationController


  def show
  	@user_picture = UserPicture.new
  end

  def create
  	@user_picture = current_user.user_pictures.build(user_picture_params)
    if @user_picture.save
      flash[:success] = '上传成功！'
      redirect_to :back
    else
      flash[:danger] = '上传失败，请重新上传！'
      redirect_to :back
    end
  end

  def update
  	
  end

  def destroy
    @user_picture = UserPicture.find(params[:id])
    @user_picture.destroy
    flash[:success] = '删除成功！'
    redirect_to :back

  end

  def user_picture_params
    params.require(:user_picture).permit(:picture)
  end

end
