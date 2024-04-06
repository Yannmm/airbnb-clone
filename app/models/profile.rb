class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :picture

  # validates :name, :address_1, :city, :state, :country, presence: true
end
