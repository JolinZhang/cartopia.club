class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new()
    @favorite.user_id = params[:user_id]
    @favorite.car_id = params[:car_id]
    @favorite.save
    redirect_to (:back)
  end
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to (:back)
  end
end
