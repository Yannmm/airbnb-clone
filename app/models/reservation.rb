class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_one :payment, dependent: :destroy

  validates :checkin_date, presence: true

  validates :checkout_date, presence: true

  has_one :review

  scope :upcoming_reservations, -> { where("checkin_date > ?", Date.today).order(:checkin_date) }

  scope :current_reservations, -> { where("checkout_date > ?", Date.today).where("checkin_date < ?", Date.today).order(:checkout_date) }

  scope :overlapping_reservations, -> (checkin_date, checkout_date) {
    where("checkin_date <= :checkout_date AND checkout_date >= :checkin_date", { checkin_date: checkin_date, checkout_date: checkout_date })
  }
end