module CarsHelper
  def calculate_average_rating(car)
    return 0.0 if car.reviews.empty?
    car.reviews.average(:rating).round(1)
  end
end
