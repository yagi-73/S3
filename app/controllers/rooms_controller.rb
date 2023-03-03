class RoomsController < ApplicationController
  before_action :ensure_correct_user, only: [:show]
  def create
    room = Room.create
    RoomUser.create(user_id: current_user.id, room_id: room.id)
    RoomUser.create(user_id: params[:user_id], room_id: room.id)
    redirect_to room_path(room.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message_new = Message.new
    @message  = Message.new
    @user = @room.users.where.not(id: current_user.id).first
  end

  private
  def ensure_correct_user
    room = Room.find(params[:id])
    unless room.users.exists?(current_user.id)
      redirect_to users_path
    end
  end
end
