class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mother
  before_action :set_message, only: [:show, :update]
  before_action :set_doctor, only: [:index, :show, :update]


  def index
    if current_user.userable_type == "Mother"
      @messages = Message.all.where(mother: current_user.userable)
    else
      @messages = Message.all.where(doctor: current_user.userable)
    end
  end

  def show
  end

  def doctors
    @today = Date.today
    @doctors = Doctor.all.where("availabilities.date >= ?", @today)
  end

  def new
    @message = Message.new
  end

  def create
    if current_user.userable.is_a?(Mother)
      @chat = Chat.find(params[:chat_id])
      @message = Message.new(message_params)
      @message.mother = current_user.userable
      @message.doctor = @chat.doctor
      @message.chat = @chat
      @message.sender = "Mother"
      if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "chats/message",
            locals: { message: @message, user: current_user.userable_type })
        end
        format.html { redirect_to chat_path(@chat) }
      end
      else
        render "chats/show", status: :unprocessable_entity
      end
    elsif current_user.userable.is_a?(Doctor)
      @chat = Chat.find(params[:chat_id])
      @message = Message.new(message_params)
      @message.doctor = current_user.userable
      @message.mother = @chat.mother
      @message.chat = @chat
      @message.sender = "Doctor"
      if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "chats/message",
            locals: { message: @message, user: current_user.userable_type })
        end
        format.html { redirect_to chat_path(@chat) }
      end
      else
        render "chats/show", status: :unprocessable_entity
      end
    end
  end

  def update
    set_message
    @doctor = current_user unless current_user.doctor.nil?
    if @message.update(message_params)
      redirect_to messages_path, notice: 'Message mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def set_mother
    @mother = current_user.userable if current_user.userable.is_a?(Mother)
  end

  def message_params
    params.require(:message).permit(:content, :status, :mother_id, :doctor_id, :chat_id)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def set_doctor
    @doctor = current_user.userable if current_user.userable.is_a?(Doctor)
  end


end
