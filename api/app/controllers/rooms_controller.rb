class RoomsController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    auth_chatroom = current_user.room_users
    chatroom_array = auth_chatroom.map do |chatroom|
      {
        id: chatroom.room.id,
        name: chatroom.room.name,
      }
    end
    render json: chatroom_array, status: :ok
  end

end
