class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.skip_password = true unless !params[:user][:password].blank? || !params[:user][:password_confirmation].blank?

    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    @users = User.page(params[:page])
    if @users.blank?
      redirect_to admin_users_path
    else
      redirect_to :back
    end
  end

  private
  
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
