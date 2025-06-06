class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mother
  before_action :set_message, only: [:show, :update]
  before_action :set_doctor, only: [:show, :update]


  def index
    @messages = @mother.messages
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.mother = @mother

    if @message.save
      redirect_to messages_path, notice: 'Message was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_message
    @doctor = current_user unless current_user.doctor.nil?
    if @message.update(message_params)
      redirect_to messages_path, notice: 'Message was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_mother
    @mother = current_user.userable if current_user.userable.is_a?(Mother)
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def set_doctor
    @doctor = current_user.userable if current_user.userable.is_a?(Doctor)
  end
end
