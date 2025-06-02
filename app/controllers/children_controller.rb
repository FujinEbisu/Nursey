class ChildrenController < ApplicationController
  def index
    set_mother
    @children = @mother.children
  end

  def new
    @mother = User.find(params[:user_id])
    @child = Child.new
  end

  def create
    set_mother
    @child = Child.new(child_params)
    @child.mother = @mother
    if @child.save
      redirect_to user_children_path(@mother), notice: 'Child was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    set_child
    @child.destroy
    redirect_to user_children_path(current_user), notice: 'Child was successfully deleted.'
  end

  private

  def child_params
    params.require(:child).permit(:name)
  end

  def set_mother
    @mother = current_user
  end

  def set_child
    @child = Child.find(params[:id])
  end
end
