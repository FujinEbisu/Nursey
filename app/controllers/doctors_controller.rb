class DoctorsController < ApplicationController
  before_action :define_doctor, :doctor_user, only: [:index, :show, :edit, :update, :destroy]

  def index

  end

  def show
    @doctor = Doctor.find(params[:id])
    # @exists = []
    # @availability = []
    # @doctor.availabilities.each do |exist|
    #   @exists << exist.date
    # end
    # @availability = params
    # @exist = Availability.where(doctor_id: @doctor.id).pluck(:date)
    # # new_dates = @availability - @exist
    #   @availability.each do |avail|
    #   @newdate = Availability.new
    #     @newdate.doctor = @doctor
    #     @newdate.date = avail
    #     @newdate.save
    #  end
    @new_date = Availability.new

    @datelock = []
    @exists = Availability.where(doctor_id: @doctor.id)
    if @exists.any?
      @exists.map do |exist|
        @datelock << exist.date.strftime("%Y-%m-%d")
      end
    end

  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.availability = @availability
    if @doctor.save
      redirect_to doctor_path(@doctor), notice: 'Doctor was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_doctor
  end

  def update
    set_doctor
    if @doctor.update(doctor_params)
      redirect_to doctor_path(@doctor), notice: 'Doctor was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_doctor
    @doctor.destroy
    redirect_to doctors_path, notice: 'Doctor was successfully deleted.'
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :availability)
  end

  def define_doctor
    @doctor = current_user.userable
  end

  def doctor_user
    @doctor_user = current_user
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
