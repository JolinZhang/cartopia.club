class CommentController < ApplicationController
  def create
    @car = Car.find(params[:id])
    @comment = @car.comments.create(params.require(:comment).permit(:content))
    redirect_to car_show_path
  end
end
