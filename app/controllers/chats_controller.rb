class ChatsController < ApplicationController

  def index
    if current_user.userable_type == "Mother"
    @chats = Chat.all.where(mother: current_user.userable, status: "ouvert")
    @mother = current_user.userable
    else
      @chats = Chat.all.where(doctor: current_user.userable, status: "ouvert")
      @doctor = current_user.userable
    end
  end

  def show
    @message = Message.new
    if current_user.userable_type == "Doctor"
    @doctor = current_user.userable
    @chat = Chat.find(params[:id])
    @mother = Mother.find(@chat.mother_id)
    @chat.update(unread: false)
    elsif current_user.userable_type == "Mother"
    @mother = current_user.userable
    @chat = Chat.find(params[:id])
    @doctor = @chat.doctor
    end
  end

  def new
    @chat = Chat.new
    @mother = current_user.userable
    @today = Date.today
    @doctors = Doctor.all
    @dispo = []
    @doctors.each do |doctor|
      doctor.availabilities.each do |availability|
        if availability.date == @today
          @dispo << doctor
        end
      end
    end
  end

  def create
    @chat = Chat.new
    @chat.mother = current_user.userable
    @chat.doctor = Doctor.find(params[:doctor_id])
    if @chat.save
      redirect_to chat_path(@chat), notice: 'Chat was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_status
  @chat = Chat.find(params[:id])

  if @chat.update(status: params[:status])
    redirect_to chats_path, notice: "Statut mis à jour."
  else
    redirect_to chats_path, alert: "Erreur lors de la mise à jour du statut."
  end
  end

  def history
      @archived = Chat.all.where(doctor: current_user.userable, status: "archivé")
      @doctor = current_user.userable
    
      @archived = Chat.all.where(mother: current_user.userable, status: "archivé")
      @mother = current_user.userable
  end


  private
  def chat_params
    params.require(:chat).permit(:mother_id, :doctor_id)
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end

end
