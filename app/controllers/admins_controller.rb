class AdminsController < ApplicationController
  layout "admin"
  before_action :signed_in_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  def index
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      sign_in @admin
      flash[:success]="创建用户"
      redirect_to @admin
    else
      render 'new'
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:success] = "已更新"
      sign_in @admin
      redirect_to @admin
    else
      render 'edit' 
   end
 
  end

  def destroy
  end

  private
    
    def admin_params
      params.require(:admin).permit(:name, :password, :password_confirmation)
    end
end
