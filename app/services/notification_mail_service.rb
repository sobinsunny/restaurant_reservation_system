class NotificationMailService
  class << self
    def send_confirmation_mail(reservation)
      customer_mail = compose_guest_email(reservation)
      resturant_email = compose_restaurant_email(reservation)
      begin  
        customer_mail.deliver!
        resturant_email.deliver!
      rescue StandardError => e  
       puts e     
      end
    end

    def send_update_confiramtion_mail(reservation)
      customer_mail = compose_guest_update_email(reservation)
      resturant_email = compose_update_restaurant_email(reservation)
      begin 
        customer_mail.deliver!
        resturant_email.deliver!
      rescue StandardError => e 
        puts e     
      end

    end

    private

    def compose_guest_update_email(reservation)
      mail = Apostle::Mail.new('reservation_update_confirmation_to_guest', email: reservation.guest.email)
      mail.guest_count = reservation.guest_party_size
      mail.previous_guest_count = reservation.guest_party_size_change.first if reservation.guest_party_size_changed?
      mail.requested_date_time = reservation.requested_date_time.strftime('%m/%d/%Y %I:%M%p ')
      mail.previous_requested_date_time = reservation.requested_date_time_change.first.strftime('%m/%d/%Y %I:%M%p ') if reservation.requested_date_time_changed?
      mail.resturant_email_id = reservation.restaurant.email
      mail
    end

    def compose_update_restaurant_email(reservation)
      mail = Apostle::Mail.new('reservation_update_confirmation_to_restaurant', email: reservation.restaurant.email)
      mail.guest_email = reservation.guest.email
      mail.table_number = reservation.table.number
      mail.guest_count = reservation.guest_party_size
      mail.previous_guest_count = reservation.guest_party_size_change.first if reservation.guest_party_size_changed?
      mail.requested_date_time = reservation.requested_date_time.strftime('%m/%d/%Y %I:%M%p ')
      mail.previous_requested_date_time = reservation.requested_date_time_change.first.strftime('%m/%d/%Y %I:%M%p ') if reservation.requested_date_time_changed?
      mail
    end

    def compose_guest_email(reservation)
      mail = Apostle::Mail.new('reservation_confirmation_to_guest', email: reservation.guest.email)
      mail.table_number = reservation.table.number
      mail.guest_count = reservation.guest_party_size
      mail.requested_date_time = reservation.requested_date_time.strftime('%m/%d/%Y %I:%M%p ')
      mail.resturant_email_id = reservation.restaurant.email
      mail
    end

    def compose_restaurant_email(reservation)
      mail = Apostle::Mail.new('reservation_confirmation_to_restaurant', email: reservation.restaurant.email)
      mail.guest_email = reservation.guest.email
      mail.table_number = reservation.table.number
      mail.guest_count = reservation.guest_party_size
      mail.requested_date_time = reservation.requested_date_time.strftime('%m/%d/%Y %I:%M%p ')
      mail
    end
  end
end
