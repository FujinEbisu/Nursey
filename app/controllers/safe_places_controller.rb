class SafePlacesController < ApplicationController
  before_action :set_safe_place, only: [:show, :edit, :update, :destroy]
  before_action :define_mother, only: [:index, :show, :new, :create, :edit, :update, :destroy]
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
    @reviews = @safe_place.reviews
    @markers = [{
      lat: @safe_place.latitude,
      lng: @safe_place.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {safe_place: @safe_place}),
      marker_html: render_to_string(partial: "marker", locals: {safe_place: @safe_place})
    }] if @safe_place.geocoded?
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

  def edit
  end

  def update
    if @safe_place.update(safe_place_params)
      redirect_to safe_place_path(@safe_place), notice: 'Safe place bien modifié'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @safe_place.destroy
    redirect_to safe_places_path, notice: 'Safe place was successfully deleted.'
  end

  private

  def safe_place_params
    params.require(:safe_place).permit(:name, :adress, options: []).tap do |safe_place_params|
      safe_place_params[:options]&.reject!(&:blank?)
    end
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:id])
  end
  def define_mother
    @mother = current_user.userable
  end
end
