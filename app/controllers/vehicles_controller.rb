class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @bookings = @vehicle.bookings
  end

  def new
    @vehicle = current_user.vehicles.build
  end

  def create
    @vehicle = current_user.vehicles.build(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: "Vehicle successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:title, :description, :vehicle_type, :engine_size, :price_per_day, :location, :available_from, :available_to, photos: [])
  end
end
