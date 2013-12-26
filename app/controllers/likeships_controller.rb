class LikeshipsController < ApplicationController
  
  def new
  	
  end

  def create
     @likeship = current_user.likeships.build(likeship_params)
     @likeship.save
     redirect_to :back
  end

  def destroy
  	@likeship = Likeship.find(params[:id])
  	@likeship.destroy
  	redirect_to :back
  end

  private
    def likeship_params
      params.require(:likeship).permit(:likeable_type, :likeable_id)
    end
end
