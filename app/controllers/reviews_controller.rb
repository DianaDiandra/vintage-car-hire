class ReviewsController < ApplicationController
  before_action :set_car, only: %i[create]

  def create
    @review = Review.new(review_params)
    @review.car = @car
    if @review.save
      redirect_to car_path(@car), notice: "Review added!"
    else
      render "cars/show", status: :unprocessable_entity
    end
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
