class Table < ApplicationRecord
  has_many :reservations
  belongs_to :restaurant
end
