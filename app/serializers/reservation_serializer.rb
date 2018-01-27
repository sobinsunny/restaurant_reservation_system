class ReservationSerializer < ActiveModel::Serializer
  attributes :id,:requested_date_time,:guest_party_size,:guest_name,:table_name

  def guest_name
  	object.guest.name
  end
  def table_name
  	object.table.number
  end

end
