class RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.all
    render json: restaurants
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { error: restaurant.errors }, status: :error
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:email, :name, :phone_number)
  end
end
