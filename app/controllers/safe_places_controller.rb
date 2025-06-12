class SafePlacesController < ApplicationController
  before_action :set_safe_place, only: [:show, :edit, :update, :destroy]
  before_action :define_mother, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :location_params, only: [:index]

  def index
    # Get safe places near user's location if location is available
    if @user_latitude && @user_longitude
      # Find safe places within 10km radius, ordered by distance
      @safe_places = SafePlace.near([@user_latitude, @user_longitude], 1000, order: :distance)
      @safes_places = @safe_places.select { |safe| safe.rating_count > 2 || safe.rating_count == 0 }.sort_by(&:average_rating).reverse
    else
      # Fallback to showing all safe places if location is not available
      @safe_places = SafePlace.all
      @safes_places = @safe_places.select { |safe| safe.rating_count > 2 }.sort_by(&:average_rating).reverse
    end
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
    @review = Review.new
  end

  def create
    @safe_place = SafePlace.new(safe_place_params)
    @safe_place.save
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

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:id])
  end
  def define_mother
    @mother = current_user.userable
  end

  def location_params
    @user_latitude = request.location&.latitude
    @user_longitude = request.location&.longitude

    # Fallback: Try to get location from browser geolocation if available
    if params[:latitude].present? && params[:longitude].present?
      @user_latitude = params[:latitude].to_f
      @user_longitude = params[:longitude].to_f
    end
  end

end
