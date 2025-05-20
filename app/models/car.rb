class Car < ApplicationRecord
  belongs_to :user
  validates :brand, :description, :price, presence: true
end
