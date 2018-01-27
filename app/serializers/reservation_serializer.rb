class ReservationSerializer < ActiveModel::Serializer
  attributes :id,:requested_date_time,:guest_party_size,:guest_name,:table_name

  def guest_name
  	object.guest.name
  end

  def table_name
  	object.table.number
  end

  def guest_party_size
  	object.requested_date_time.strftime("%m/%d/%Y %I:%M%p ")
  end

end
