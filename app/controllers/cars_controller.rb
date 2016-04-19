class CarsController < ApplicationController
  def index
		@sort = params[:sort]
		case @sort
			when '0'
				@cars = Car.where(issold: false).order(created_at: :desc)
			when '1'
				@cars = Car.where(issold: false).order(price: :desc)
			when '2'
				@cars = Car.where(issold: false).order(:price)
			when '3'
				@cars = Car.where(issold: false).order(mileage: :desc)
			when '4'
				@cars = Car.where(issold: false).order(:mileage)
			when '5'
				@cars = Car.where(issold: false).order(year: :desc)
			when '6'
				@cars = Car.where(issold: false).order(:year)
			when '7'
				@cars = Car.where(issold: false).order(:make, :model)
			else
				@cars = Car.where(issold: false).order(created_at: :desc)
		end
	end

	def new
		if did_login?
			@car = Car.new
		else
			redirect_to login_path
		end
	end

	def create
		@car = Car.new(params.require(:car).permit(:year, :make, :model, :mileage, :price, :contact, :city, :state,:notes))
		respond_to do |format|
		@car.user_id = current_user.id
		@car.issold = false
		if @car.save
			#save picture name = userid-carid
			uploaded_io = params[:car][:picture]
      if uploaded_io
  			@car.picture = @car.user_id.to_s+"-"+@car.id.to_s+File.extname(uploaded_io.original_filename)
  			@car.save
  			#upload picture
  			File.open(Rails.root.join('app','assets','images','user_car',@car.picture.to_s),'wb') do |file|
  				file.write(uploaded_io.read)
        end
      else
        @car.picture = 'default.jpg'
        @car.save
      end
			format.js {  }
	  else
			format.js {  }
		end
		end
	end

  def show
		@car = Car.find(params[:id])
	end

  def destroy
  	@car = Car.find(params[:id])
    @car.destroy
    redirect_to  manager_cars_path
  end

  def update
    @car = Car.find(params[:id])
    @car.update(params.require(:car).permit(:issold))
    @car.save
    redirect_to car_path
  end
  def search
		@cars = Car.all
		if params[:car][:make] != ""
			@cars = @cars.select{|a| a.make == params[:car][:make]}
		end
		if params[:car][:model] != ""
			@cars = @cars.select{|a| a.model == params[:car][:model]}
		end
		if params[:car][:year] != ""
			@cars = @cars.select{|a| a.year.to_s == params[:car][:year]}
		end
		render 'cars/index'
  end
end
