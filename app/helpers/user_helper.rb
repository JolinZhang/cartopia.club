module UserHelper
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def did_login?
		!current_user.nil?
	end

	def perform_logout
		session.delete(:user_id)
		@current_user = nil
	end
end
