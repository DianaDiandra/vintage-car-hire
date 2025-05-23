class Review < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :rating, inclusion: { in: 0..5, message: "should be between 0 to 5" }
  validates :comment, presence: true
end
