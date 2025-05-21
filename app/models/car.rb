class Car < ApplicationRecord
  has_many :reviews
  has_one_attached :image
  belongs_to :user
  validates :brand, :description, :price, presence: true
end
