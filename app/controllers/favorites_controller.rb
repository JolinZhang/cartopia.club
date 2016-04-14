class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new()
    @favorite.user_id = params[:user_id]
    @favorite.car_id = params[:car_id]
    @favorite.save
  end
  def show
  end
end
