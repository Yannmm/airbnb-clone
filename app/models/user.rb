class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishlists, dependent: :destroy

  has_many :wishlisted_properties, through: :wishlists, source: :property, dependent: :destroy


  has_many :reservations, dependent: :destroy

  has_many :reserved_properties, through: :reservations, source: :property, dependent: :destroy

  has_many :payments, through: :reservations, source: :payment, dependent: :destroy

  has_one :profile, dependent: :destroy

  has_many :reviews, dependent: :destroy

  after_create :create_profile

  private 
  def create_profile
    self.profile = Profile.new
    self.save!
  end
end
