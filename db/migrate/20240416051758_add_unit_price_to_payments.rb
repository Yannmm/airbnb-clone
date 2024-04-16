class AddUnitPriceToPayments < ActiveRecord::Migration[7.1]
  def change
    add_monetize :payments,
    :unit_price,
    amount: { null: true, default: nil },
    currency: { null: true, default: nil }
  end
end
