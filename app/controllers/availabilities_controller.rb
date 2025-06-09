class AvailabilitiesController < ApplicationController
  before_action :set_doctor, only: [:update]

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @datelock = Availability.where(doctor_id: @doctor.id).pluck(:date).map(&:strftime).uniq
    @availability = params[:availability][:date]
    @availability = @availability.split(',').map(&:strip) if @availability.is_a?(String)
    @new_dates = @availability - @datelock
    success = true
    @new_dates.each do |date|
      @lol = Availability.new
      @lol.date = date
      @lol.doctor = @doctor
      success = false unless @lol.save
    end
    if success
      redirect_to doctor_path(@doctor), notice: 'Availability was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @availability = Availability.where(doctor_id: @doctor.id)
    if @availability.update(availability_params)
      redirect_to doctor_path(@availability.doctor), notice: 'Availability was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def availability_params
    params.require(:availability).permit(:date, :doctor_id)
  end
  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

end
