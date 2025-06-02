class ReviewsController < ApplicationController
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
  end

  def create
    set_safe_place
    @review = Review.new(review_params)
    @review.safe_place = @safe_place
    @review.user = current_user

    if @review.save
      redirect_to safe_place_reviews_path(@safe_place), notice: 'Review was successfully created.'
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
      redirect_to safe_place_review_path(@safe_place, @review), notice: 'Review was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_safe_place
    set_review
    @review.destroy
    redirect_to safe_place_reviews_path(@safe_place), notice: 'Review was successfully deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :safe_place_id)
  end

  def set_safe_place
    @safe_place = SafePlace.find(params[:safe_place_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
