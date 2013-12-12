class UsersController < ApplicationController
  layout "user"
  before_action :find_user, only: [:show, :edit]
  def index
  	@user = User.page(params[:page])
  end

  def show

  end

  def edit
  	
  end

  def update
    @user = User.find(users_params)
    
  end

  def create
    
  end


  private
    def find_user
      @user = User.find(params[:id])
    end

    def users_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

end
