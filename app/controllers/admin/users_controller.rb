class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.user_search(params).paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '创建成功！'
      redirect_to admin_users_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.skip_password = true unless !params[:user][:password].blank? || !params[:user][:password_confirmation].blank?

    if @user.update(user_params)
      flash[:success] = '更新成功！'
      redirect_to admin_users_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    @users = User.paginate(page: params[:page])
    flash[:success] = '删除成功！'
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
      params.require(:user).permit(:email, :name, :description, :password, :password_confirmation, roles: [])
    end
end
