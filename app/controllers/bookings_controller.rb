class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car

  def index
   @bookings = @car.bookings.where(user: current_user)
   @booking = Booking.new
  end

  def new
    @booking = @car.bookings.new
  end

  def create
    @booking = @car.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to car_bookings_path(@car), notice: 'Booking added successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

   def edit
    return if @booking.user == current_user
    redirect_to root_path, alert: "Not authorized!"
  end

  def update
    if @booking.user != current_user
      redirect_to root_path, alert: "Not authorized!"
      return
    end

    if @booking.update(booking_params)
      redirect_to car_bookings_path(@car), notice: "Booking updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = @car.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
