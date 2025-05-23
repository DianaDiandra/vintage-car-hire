class AddGeocodingToCars < ActiveRecord::Migration[7.2]
  def change
    add_column :cars, :address, :string
    add_column :cars, :latitude, :float
    add_column :cars, :longitude, :float
  end
end
