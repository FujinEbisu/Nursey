class FeedsController < ApplicationController
  ##### test mood #####
  MOOD_OPTIONS = {
    "😁" => 5,
    "🙂" => 4,
    "😐" => 3,
    "😒" => 2,
    "😡" => 1
}
  ##### test mood #####
  def index
    @feeds = Feed.all.where(mother: current_user.userable)
    @mother = current_user.userable
    @children = @mother.children
  end

  def show
    @feed = Feed.find(params[:id])
    @child = @feed.child
    @mother = current_user.userable
  end

  def new
    @feed = Feed.new
    @mother = current_user.userable
    @children = @mother.children
    @mood_options = MOOD_OPTIONS
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.mother = current_user.userable
    @mother = current_user.userable
    if @feed.save
      redirect_to mother_feeds_path(@feed.mother), notice: 'La Tetée a bien été créée.'
    else
      @children = current_user.userable.children
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @mother = current_user.userable
    @feed = Feed.find(params[:id])
    @children = @mother.children
  end

  def update

    @mother = current_user.userable
    @feed = Feed.find(params[:id])

    if @feed.update(feed_params)
      redirect_to mother_feed_path(@feed), notice: 'La Tetée a bien été modifiée.'
    else
      @children = current_user.children
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mother = current_user.userable
    set_feed
    @feed.destroy
    redirect_to mother_feed_path(@mother), notice: 'La Tetée a bien été supprimée.'
  end

  private

  def feed_params
    params.require(:feed).permit(:quantity_left, :quantity_right, :time_left, :time_right, :mood, :nursy_type, :comment, :child_id)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
