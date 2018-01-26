class Guest < ApplicationRecord
  has_many :reservations

  validates :email, :name, presence: true
  validates_uniqueness_of :email, message: 'email is already registered !'
  validates_email_format_of :email, message: 'email is not correct !'
end
