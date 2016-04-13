class CarController < ApplicationController
	def list
		@cars= Car.all
	end
	def new
		@car = Car.new
	end
	def create
		@car = Car.new(params.require(:car).permit(:year, :make, :model, :mileage, :price, :contact, :city,
		:state,:notes))
		@car.user_id = current_user.id
		@car.issold = false
  if @car.save
		#save picture name = userid+carid
		uploaded_io = params[:car][:picture]
		@car.picture = @car.user_id.to_s+@car.id.to_s+File.extname(uploaded_io.original_filename)
		@car.save
		#upload picture
		File.open(Rails.root.join('app','assets','images','user_car',@car.user_id.to_s+@car.id.to_s+File.extname(uploaded_io.original_filename) ),
		'wb') do |file|
			file.write(uploaded_io.read)
		end
		redirect_to  car_list_path
	  else
		render 'car/new'
	end
	end
  def show
		@car = Car.find(params[:id])
	end


end
