class MothersController < ApplicationController
    before_action :define_mother, :mother_user, only: [:index, :show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @mother = Mother.new
  end

  def create
    @mother = Mother.new(mother_params)
    if @mother.save
      redirect_to mother_path(@mother), notice: 'Votre compte a bien été créé.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    ## should update mothers details and redirect to the mother profile page
    @mother.update(mother_params)
    if @mother.update(mother_params)
      redirect_to mother_path(@mother), notice: 'Vos détails ont été mis à jour.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private 

  def mother_params
    params.require(:mother).permit(:first_name, :last_name, :birthday, :time_between_feed, :avatar)
  end

  def define_mother
    @mother = current_user.userable
  end

  def mother_user
    @mother_user = current_user
  end

end

