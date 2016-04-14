class CarsController < ApplicationController
  def index
		@sort = params[:sort]
		case @sort
			when '0'
				@cars = Car.order(:created_at)
			when '1'
				@cars = Car.order(price: :desc)
			else 
				@cars = Car.order(:created_at)
		end
	end

	def new
		@car = Car.new
	end

	def create
		@car = Car.new(params.require(:car).permit(:year, :make, :model, :mileage, :price, :contact, :city, :state,:notes))
		@car.user_id = current_user.id
		@car.issold = false
		if @car.save
			#save picture name = userid-carid
			uploaded_io = params[:car][:picture]
			@car.picture = @car.user_id.to_s+"-"+@car.id.to_s+File.extname(uploaded_io.original_filename)
			@car.save
			#upload picture
			File.open(Rails.root.join('app','assets','images','user_car',@car.picture.to_s),'wb') do |file|
				file.write(uploaded_io.read)
			end
			redirect_to  cars_path
	  else
			render 'new'
		end
	end

  def show
		@car = Car.find(params[:id])
	end
end
