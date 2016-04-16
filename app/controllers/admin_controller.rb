class AdminController < ApplicationController

  def cars
    @cars = Car.all.order(created_at: :desc)
  end

	def users
		@users = User.all.order(created_at: :desc)
	end
end
