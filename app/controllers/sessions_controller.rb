class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email].downcase)
    respond_to do |format|
      if @user && @user.authenticate(params[:password])
        sign_in @user
        remember_me if params[:remember_me]
        format.html { redirect_to :back }
        format.js
      else
        @error_msg = '邮箱地址或密码有误，请重新输入！'
        format.html { redirect_to :back }
        format.js
      end
    end
  end 

  def destroy
    sign_out
    redirect_to root_path
  end
end
