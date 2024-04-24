class AddLatitudeAndLongitudeToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :latitude, :decimal, default: 0
    add_column :properties, :longitude, :decimal, default: 0
  end
end
