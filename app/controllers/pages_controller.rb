class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @five_star_reviews = Review.where(rating: 5).limit(10)
  end
end
