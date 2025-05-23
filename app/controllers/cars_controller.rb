class CarsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # Line above ensures only logged-in host can create cars
  def index
    @cars = Car.all
    # This collects all car records from db and stores in @car
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: { car: car })
      }
    end
  end

  def show
    @car = Car.find(params[:id])
    @reviews = @car.reviews
    @review = Review.new
    @average_rating = @car.reviews.average(:rating).to_f.round(1)

    @markers = [{
      lat: @car.latitude,
      lng: @car.longitude,
      info_window_html: render_to_string(partial: "cars/info_window", locals: { car: @car }),
      marker_html: render_to_string(partial: "cars/marker", locals: { car: @car })
    }]

    @booking = Booking.new
  end

  def new
    @car = current_user.cars.new
    @booking = Booking.new
    # Current user gets pre-assigned a car
  end

  def create
    @car = current_user.cars.new(car_params) # Ensures car is associated to the user immediately
    if @car.save
      redirect_to @car, notice: 'Car listed!' # Will redirect to car page if successfull
    else
      render :new, status: :unprocessable_entity # Will show form if it fails
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :description, :price, :availability, :image)
  end
end
