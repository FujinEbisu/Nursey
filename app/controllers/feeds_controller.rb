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
    @feeds = Feed.all
    @mother = current_user.userable
    @children = @mother.children
  end

  def show
    @feed = Feed.find(params[:id])
    @child = @feed.child
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
    if @feed.save
      redirect_to feed_path(@feed), notice: 'Feed was successfully created.'
    else
      @children = current_user.children
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @mother = current_user.userable
    set_feed
    @children = @mother.children
  end

  def update
    @mother = current_user.userable
    set_feed
    if @feed.update(feed_params)
      redirect_to feed_path(@feed), notice: 'Feed was successfully updated.'
    else
      @children = current_user.children
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mother = current_user.userable
    set_feed
    @feed.destroy
    redirect_to mother_feed_path(@mother), notice: 'Feed was successfully deleted.'
  end

  private

  def feed_params
    params.require(:feed).permit(:quantity_left, :quantity_right, :time_left, :time_right, :mood, :type)
  end

  def set_feed
    @feed = Feed.find(params[:mother_id])
  end
end
