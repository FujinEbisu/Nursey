class MothersController < ApplicationController
  def show
    @mother = current_user
  end

  def new
  end

  def create
    @mother = Mother.new(mother_params)
    if @mother.save
      redirect_to mother_path(@mother), notice: 'Mother was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
