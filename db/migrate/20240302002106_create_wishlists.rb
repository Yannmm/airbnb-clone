class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|
      # default index: { unique: false }, foreigh_key: true
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end

    # Create a multi-column index
    add_index :wishlists, [:user_id, :property_id], unique: true
  end
end
