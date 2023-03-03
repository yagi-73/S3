class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  # before_action :judgment_reciprocal_followings

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    unless @user == current_user
      current_user.rooms.each do |current_user_room|
        if @user.rooms.exists?(current_user_room.id)
          @isRoom = true
          @room = @user.rooms.find(current_user_room.id)
        end
      end
    end
    # unless @isRoom
    #   @room_user = RoomUser.new
    #   @room = Room.new
    # end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  # private
  # def judgment_reciprocal_followings
  #   user = User.find(params[:id])
  #   unless current_user.following?(user) && user.following?(current_user)
  #     redirect_to 
  #   end
  # end
end
