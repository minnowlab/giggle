class UsersController < ApplicationController
  layout "user"

  def index
  end

  def show
  end

  def edit
  end

  def update

  end

  def create
    
  end

  def change_password
  end

  def change_name
  end

  def update_name
    if current_user.authenticate(params[:user][:password])
      current_user.skip_password = true
      current_user.update(name: params[:user][:name])
      flash[:success] = '修改成功！'
      redirect_to user_path
    else
      flash.now[:danger] = '修改失败，请输入正确密码！'
      render 'change_name'
    end
  end

  def update_password
    if current_user.authenticate(params[:user][:old_password])
      if current_user.update(update_new_password)
        flash[:success] = '修改成功！'
        redirect_to user_path
      else
      flash.now[:danger] = '修改失败，请重新输入！'
      render 'change_password'
      end
    else
      flash.now[:danger] = '修改失败，请重新输入！'
      render 'change_password'
    end
  end

  def setting_cover
    current_user.skip_password = true
    current_user.update(cover_id: params[:cover_id])
    flash[:success] = '设置成功！'
    redirect_to user_picture_path(current_user)
  end

  def show_user
    @user = User.find(params[:id])
  end

  def show_users
    @users = User.all.page(params[:page])
  end

  private
    def users_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
  
    def update_new_password
      params.require(:user).permit(:password, :password_confirmation)
    end

end
