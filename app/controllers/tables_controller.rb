class TablesController < ApplicationController
  before_action :set_resturant

  def index
    tables = Table.where(restaurant: @current_restaurant)
    render json: tables
  end

  def create
    table = Table.new(table_params.merge(restaurant: @current_restaurant))
    table.save
    render json: table
  end

  private

  def table_params
    params.require(:table).permit(:number, :number_of_seats)
  end
  
end
