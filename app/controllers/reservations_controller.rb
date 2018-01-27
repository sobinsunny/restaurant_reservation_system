class ReservationsController < ApplicationController
  before_action :set_resturant,only: %i[create index]

  def index
    reservations = @current_restaurant.reservations
    render json: reservations
  end

  def create
    raise ExceptionHandler::OutofShiftTimeExceptionError unless include_between_shift_time? and should_be_future_time
    reservation = ReservationService.create_reservation(
      guest_email: reservation_create_params[:guest_email],
      guest_name: reservation_create_params[:guest_name],
      guest_party_size: reservation_create_params[:guest_party_size],
      requested_date_time: reservation_create_params[:requested_date_time],
      restaurant: @current_restaurant
    )
    render json: reservation
  end

  def update
    set_reservation
    raise ExceptionHandler::OutofShiftTimeExceptionError unless include_between_shift_time? and should_be_future_time
    ReservationService.update_reservation(reservation: @reservation, update_reservation_params: reservation_update_params)
    render json: @reservation
  end

  private

  def include_between_shift_time?
    (parse_time('9 AM')..parse_time('1 PM')).cover?(parse_time(reservation_create_params[:requested_date_time])) ||
      (parse_time('6 PM')..parse_time('11 PM')).cover?(parse_time(reservation_create_params[:requested_date_time]))
   end

  def should_be_future_time
    DateTime.parse(reservation_create_params[:requested_date_time]) > DateTime.current
   end

  def set_reservation
    @reservation ||= Reservation.find(params[:id])
   end

  def reservation_create_params
    params.require(:reservation).permit(:guest_email, :guest_name, :guest_party_size, :requested_date_time)
   end

  def reservation_update_params
    params.require(:reservation).permit(:guest_party_size, :requested_date_time)
  end

  def parse_time(time)
    DateTime.parse(time).strftime('%H:%M')
  end

end
