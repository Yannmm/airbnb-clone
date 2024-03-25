class AddColumnToAmenities < ActiveRecord::Migration[7.1]
  def change
    add_column :amenities, :icon, :string
  end
end
