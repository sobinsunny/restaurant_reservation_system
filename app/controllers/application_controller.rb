class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def set_guest
    @current_user ||= Guest.find_by(email: params[:guest_email])
    end
end
