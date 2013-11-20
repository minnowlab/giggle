class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
