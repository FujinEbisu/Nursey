class ReviewsController < ApplicationController
  before_action :define_mother, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # *** test star rating ***
  STAR_OPTIONS = {
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5
  }
  # *************************

  def index
    @safe_place = SafePlace.find(params[:safe_place_id])
    @reviews = @safe_place.reviews
  end

  def show
    set_safe_place
    set_review
  end

  def new
    set_safe_place
    @review = Review.new
    @star_options = STAR_OPTIONS
  end

  def create
    set_safe_place
    @review = Review.new(review_params)
    @review.safe_place = @safe_place
    @review.mother = @mother
    if @review.save
      redirect_to safe_place_path(@safe_place), notice: 'Avis ajouté.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_safe_place
    set_review
  end

  def update
    set_safe_place
    set_review
    if @review.update(review_params)
      redirect_to safe_place_path(@safe_place), notice: 'Avis mis à jour.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_safe_place
    set_review
    @review.destroy
    redirect_to safe_place_path(@safe_place), notice: 'Avis supprimé.'
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:safe_place_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def define_mother
    @mother = current_user.userable
  end
end
