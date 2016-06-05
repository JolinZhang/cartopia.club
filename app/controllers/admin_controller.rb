class AdminController < ApplicationController

  def cars
		if did_login?
			if current_user.isadmin
				@cars = Car.all.order(created_at: :desc)
			else
				redirect_to root_path
			end
		else
			redirect_to login_path
		end
  end

	def users
		if did_login?
			if current_user.isadmin
				@users = User.all.order(created_at: :desc)
			else
				redirect_to root_path
			end
		else
			redirect_to login_path
		end
	end
end
