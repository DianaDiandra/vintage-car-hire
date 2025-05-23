class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews
  has_one_attached :image
  belongs_to :user
  validates :brand, :description, :price, presence: true
end
