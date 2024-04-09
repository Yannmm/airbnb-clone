class AddDefaultValueToAvarageFinalRatingInProperties < ActiveRecord::Migration[7.1]
  def up
    change_column :properties, :average_final_rating, :decimal, default: 0
    change_column :properties, :reviews_count, :integer, default: 0
  end

  def down
    change_column :properties, :average_final_rating, :decimal
    change_column :properties, :reviews_count, :integer
  end
end
