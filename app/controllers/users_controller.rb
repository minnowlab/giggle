class UsersController < ApplicationController
  before_action :find_user, only: [:show, :all_evaluates]
  layout "user", except: [:new, :create]

  def index
    @users = User.select("id, name").order("RANDOM()").limit(10)
    render json: @users
  end

  def show
    @collections = @user.collections.order("id DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(roles_mask: 4))
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def all_evaluates
    @evaluates = @user.evaluates.order("id DESC")
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
