class ChangeCountryToCountryCodeForProfiles < ActiveRecord::Migration[7.1]
  def change
    rename_column :profiles, :country, :country_code
  end
end
