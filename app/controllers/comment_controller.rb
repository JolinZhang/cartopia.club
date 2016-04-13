class CommentController < ApplicationController
  def create
    @car = Car.find(params[:id])
    @comment = Comment.new(params.require(:comment).permit(:content))
    @comment.user_id = current_user.id
    @comment.car_id = @car.id
    @comment.save
    redirect_to car_show_path
  end
end
