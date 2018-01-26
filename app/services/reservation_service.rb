class ReservationService
  class << self
    def get_reservations(restaurant:)
      restaurant.reservations
    end

    def create_reservation(restaurant:, guest_email:, guest_name:, guest_party_size:, requested_date_time:)
      tables = available_tables(restaurant: restaurant, guest_party_size: guest_party_size, requested_date_time: requested_date_time)
      raise ExceptionHandler::ReservationAvailabityError if tables.nil? || tables.none?
      guest = Guest.create_with(name: guest_name).find_or_create_by(email: guest_email)
      Reservation.create(table: tables.first, guest: guest, guest_party_size: guest_party_size, requested_date_time: requested_date_time)
    end

    def update_reservation(reservation:, update_reservation_params:)
      raise ExceptionHandler::ReservationAvailabityError if reservation.table.number_of_seats < update_reservation_params[:guest_party_size].to_i
      reservation.update(update_reservation_params)
    end

    private

    def available_tables(restaurant:, guest_party_size:, requested_date_time:)
      reservation_time = DateTime.parse(requested_date_time)
      time_range = reservation_time..(reservation_time + 1.hour)
      booked_tables = reserved_tables(restaurant: restaurant, time_range: time_range)
      Table.where('number_of_seats >= ? and restaurant_id = ?', guest_party_size, restaurant.id).order(number_of_seats: :ASC) - booked_tables
    end

    def reserved_tables(restaurant:, time_range:)
      Table.joins(:reservations).where(reservations: { requested_date_time: time_range }, restaurant: restaurant)
    end
  end
end
