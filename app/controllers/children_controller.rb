class ChildrenController < ApplicationController
  def index
    set_mother
    @children = @mother.children
  end

  def new
    set_mother
    @child = Child.new
  end

  def create
    set_mother
    @child = Child.new(child_params)
    @child.mother = @mother
    if @child.save
      redirect_to mother_children_path(@mother), notice: 'Enfant ajouté avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    set_mother
    set_child
    @child.destroy
    redirect_to mother_children_path(@mother), notice: 'Enfant supprimé avec succès.'
  end

  private

  def child_params
    params.require(:child).permit(:first_name, :sexe)
  end

  def set_mother
    @mother = current_user.userable
  end

  def set_child
    @child = Child.find(params[:id])
  end
end
