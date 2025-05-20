class BookingsController < ApplicationController
  before_action :set_car

  def index
   @bookings = @car.bookings.where(user: current_user)
   @booking = Booking.new
  end

  def create
    @booking = @car.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to car_bookings_path(@car), notice: 'Booking added successfully!'
    else
      @bookings = @car.bookings.where(user: current_user)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @booking = @car.bookings.find(params[:id])
    if @booking.update(booking_params)
      redirect_to car_bookings_path(@car), notice: "Booking updated successfully!"
    else
      @bookings = @car.bookings.where(user: current_user)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
