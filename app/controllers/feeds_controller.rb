class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
    @child = @feed.child
  end

  def new
    @feed = Feed.new
    @mother = current_user.userable
    @children = @mother.children
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.mother = current_user
    if @feed.save
      redirect_to feed_path(@feed), notice: 'Feed was successfully created.'
    else
      @children = current_user.children
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_feed
    @children = current_user.children
  end

  def update
    set_feed
    if @feed.update(feed_params)
      redirect_to feed_path(@feed), notice: 'Feed was successfully updated.'
    else
      @children = current_user.children
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_feed
    @feed.destroy
    redirect_to feeds_path, notice: 'Feed was successfully deleted.'
  end

  private

  def feed_params
    params.require(:feed).permit(:quantity_left, :quantity_right, :time_left, :time_right, :mood, :type)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
