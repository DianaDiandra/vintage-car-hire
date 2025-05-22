class CarsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # Line above ensures only logged-in host can create cars
  def index
    @cars = Car.all
    # This collects all car records from db and stores in @car
  end

  def show
    @car = Car.find(params[:id])
    @reviews = @car.reviews
    @review = Review.new
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
      redirect_to cars_path, notice: 'Car listed!' # Will redirect to car page if successfull
    else
      render :new, status: :unprocessable_entity # Will show form if it fails
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :description, :price, :availability, :image)
  end
end
