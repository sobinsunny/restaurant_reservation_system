class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations, through: :tables

  validates :email, :name, :phone_number, presence: true
  validates_uniqueness_of :email, message: 'email is already registered !'
  validates_email_format_of :email, message: 'email is not correct !'
  validates :phone_number, numericality: true,
                           length: { minimum: 10, maximum: 15, message: ' Invalid Phone number!' }
end
