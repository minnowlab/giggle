class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      remember_me if params[:remember_me]
      redirect_to root_path
    else
      flash[:danger] = '邮箱地址或密码有误，请重新输入！'
      render 'new'
    end
  end 

  def destroy
    sign_out
    redirect_to root_path
  end
end
