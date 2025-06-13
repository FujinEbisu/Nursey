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
    # minutes1 = params[:feed]["time_left"]

    # minutes2 = params[:feed]["time_right(4i)"].to_i
    # seconds2 = params[:feed]["time_right(5i)"].to_i
    # @feed.time_left = minutes1 * 60 + seconds1
    # @feed.time_right = minutes2 * 60 + seconds2
    # debugger
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
    params.require(:feed).permit( :nursy_type, :comment, 
                                  :mood, :child_id,
                                  :time_left_minutes, :time_left_seconds,
                                  :time_right_minutes, :time_right_seconds,
                                  :quantity_left, :quantity_right
    )
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
