class AddGeolocation < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :latitude, :float
    add_column :pets, :longitude, :float
    add_column :shelters, :latitude, :float
    add_column :shelters, :longitude, :float
  end
end
