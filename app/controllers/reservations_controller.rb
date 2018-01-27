class ReservationsController < ApplicationController
  rescue_from ExceptionHandler::ReservationAvailabityError, with: :render_reservation_capacity_error
  rescue_from ExceptionHandler::OutofShiftTimeExceptionTime, with: :render_out_of_shift_time_error

  def index
    set_resturant
    reservations = @current_restaurant.reservations
    render json: reservations
  end

  def create
    # params refactoring
    set_resturant
    raise ExceptionHandler::OutofShiftTimeExceptionTime unless include_between_shift_time? && should_be_future_time
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
    raise ExceptionHandler::OutofShiftTimeExceptionTime unless include_between_shift_time? && should_be_future_time
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

  def set_resturant
    @current_restaurant ||= Restaurant.find_by(email: params[:restaurant_email])
   end

  def render_reservation_capacity_error
    render json: { message: 'Reservation capacity exceeded' }, status: :unprocessable_entity
   end

  def parse_time(time)
    DateTime.parse(time).strftime('%H:%M')
   end

  def render_out_of_shift_time_error
    render json: { message: 'Resturant will open in this time' }, status: :unprocessable_entity
   end
end
