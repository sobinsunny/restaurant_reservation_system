module ExceptionHandler
	extend ActiveSupport::Concern
	class ReservationAvailabityError < StandardError; end
	class OutofShiftTimeExceptionError < StandardError; end
	class MissingParamsError < StandardError; end
	class RestaurantNotoundException < StandardError; end

	included do
    # Define custom handlers
	    rescue_from ExceptionHandler::ReservationAvailabityError, with: :render_reservation_capacity_error
	    rescue_from ExceptionHandler::MissingParamsError, with: :missing_params
	    rescue_from ExceptionHandler::OutofShiftTimeExceptionError, with: :render_out_of_shift_time_error
	    rescue_from ExceptionHandler::RestaurantNotoundException, with: :render_restaurant_not_error
	end

private

   # JSON response with message; Status code 401 - Unauthorized
  def render_reservation_capacity_error
   	render json: { message: 'Reservation capacity exceeded' }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 422 - unprocessable entity
  def missing_params(e)
  	render json: { message: e.message }, status: :unprocessable_entity
  end


  def render_out_of_shift_time_error
   	render json: { message: 'Resturant will not open in this time' }, status: :unprocessable_entity
  end

  def render_restaurant_not_error
  	render json: { message: 'Resturant is not present' }, status: :unprocessable_entity
  end

end