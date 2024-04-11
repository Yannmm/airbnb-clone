class ChangeCountryToCountryCodeForProperties < ActiveRecord::Migration[7.1]
  def change
    rename_column :properties, :country, :country_code
  end
end
