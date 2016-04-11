class CarController < ApplicationController
	def list
		@cars= Car.all
	end
	def new
	end
	def create
		uploaded_io = params[:car][:picture]
		File.open(Rails.root.join('app','assets','images','user_car',uploaded_io.original_filename),
		'wb') do |file|
			file.write(uploaded_io.read)
		end
	end
end
  
