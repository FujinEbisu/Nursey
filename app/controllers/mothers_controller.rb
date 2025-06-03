class MothersController < ApplicationController
  before_action :define_mother, only: [:index, :show, :edit, :update, :destroy]

  def index
  end

  def show
    raise
  end

  def new
    @mother = Mother.new
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

  private 

  def define_mother
    @mother = current_user.userable
  end
end
