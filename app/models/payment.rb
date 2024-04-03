class Payment < ApplicationRecord
  belongs_to :reservation

  monetize :base_fare_cents, allow_nil: false

  monetize :service_fee_cents, allow_nil: false

  monetize :total_before_taxes_cents, allow_nil: false
end
