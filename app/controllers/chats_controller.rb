class ChatsController < ApplicationController

  def index
    if current_user.userable_type == "Mother"
    @chats = Chat.all.wherere(mother: current_user.userable)
    else
      @chats = Chat.all.where(doctor: current_user.userable)
    end
  end

def show
    @chat = Chat.find(params[:id])
end

  def new
    @chat = Chat.new
    @today = Date.today
    @doctors = Doctor.all.where("availabilities.date >= ?", @today)
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.mother = current_user.userable if current_user.userable.is_a?(Mother)
    @chat.doctor = current_user.userable if current_user.userable.is_a?(Doctor)

    if @chat.save
      redirect_to chats_path, notice: 'Chat was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  private
  def chat_params
    params.require(:chat).permit(:mother_id, :doctor_id)
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end

end
