class SafePlacesController < ApplicationController
  def index
    @safe_places = SafePlace.all
  end

  def show
    @safe_place = SafePlace.find(params[:id])
    @reviews = @safe_place.reviews
  end

  def new
    @safe_place = SafePlace.new
  end

  def create
    @safe_place = SafePlace.new(safe_place_params)
    if @safe_place.save
      redirect_to safe_place_path(@safe_place), notice: 'Safe place was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def safe_place_params
    params.require(:safe_place).permit(:name, :address, :options)
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:id])
  end
end
