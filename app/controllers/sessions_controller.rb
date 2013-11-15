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
      flash.now[:error] = 'Invalid name/passowrd'
      render 'new'
    end
  end 

  def destroy
    sign_out
    redirect_to signin_path
  end
end
