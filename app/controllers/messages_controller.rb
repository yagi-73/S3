class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to room_path(@message.room.id)
    else
      @room = @message.room
      @messages = @room.messages
      @message_new = Message.new
      @user = @room.users.where.not(id: current_user.id).first
      render template: 'rooms/show'
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :room_id)
  end
end
