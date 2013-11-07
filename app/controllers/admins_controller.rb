class AdminsController < ApplicationController
  layout "admin"
  def index
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success]="create admin"
      redirect_to @admin
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
    
    def admin_params
      params.require(:admin).permit(:name, :password, :password_confirmation)
    end
end
