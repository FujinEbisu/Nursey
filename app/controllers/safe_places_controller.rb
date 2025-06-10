class SafePlacesController < ApplicationController
  def index
    @safe_places = SafePlace.all
    @markers = @safe_places.geocoded.map do |safe_place|
      {
        lat: safe_place.latitude,
        lng: safe_place.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {safe_place: safe_place}),
        marker_html: render_to_string(partial: "marker", locals: {safe_place: safe_place})
      }
    end
  end

  def show
    @safe_place = SafePlace.find(params[:id])
    @reviews = @safe_place.reviews
  end

  def new
    @safe_place = SafePlace.new
  end

  def edit
    @safe_place = SafePlace.find(params[:id])
  end

  def update
    @safe_place = SafePlace.find(params[:id])
    if @safe_place.update(safe_place_params)
      redirect_to safe_place_path(@safe_place), notice: 'Safe place was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @safe_place = SafePlace.find(params[:id])
    @safe_place.destroy
    redirect_to safe_places_path, notice: 'Safe place was successfully deleted.'
  end

  def create
    debugger
    @safe_place = SafePlace.new(safe_place_params)
    if @safe_place.save
      redirect_to safe_place_path(@safe_place), notice: 'Safe place was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def safe_place_params
    params.require(:safe_place).permit(:name, :adress, :options)
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:id])
  end
end
