class TableSerializer < ActiveModel::Serializer
  attributes :id,:number,:number_of_seats
  belongs_to :restaurant

  def number
  	"table-" + object.number.to_s
  end
end
