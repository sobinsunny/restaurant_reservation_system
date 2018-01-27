class ApplicationController < ActionController::API
	include ExceptionHandler
	attr_reader :current_user
	private

	protected

	def set_resturant
		@current_restaurant ||= Restaurant.find_by(email: params[:restaurant_email])
		raise ExceptionHandler::RestaurantNotoundException  unless @current_restaurant.present?
	end

	def set_guest
		@current_user ||= Guest.find_by(email: params[:guest_email])
	end
end
