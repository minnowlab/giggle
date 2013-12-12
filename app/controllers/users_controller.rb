class UsersController < ApplicationController
  layout "user"

  def index

  end

  def show

  end

  def edit
  	
  end

  def update

    if current_user.authenticate(params[:user][:password])
      current_user.save(email: params[:user][:email])
      flash[:success] = '修改成功！'
      redirect_to user_path
    else
      flash.now[:danger] = '修改失败，请重新输入！'
      render 'change_email'
    end
    
  end

  def create
    
  end

  def change_password
    
  end

  def change_email
    
  end

  private
    def users_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

end
