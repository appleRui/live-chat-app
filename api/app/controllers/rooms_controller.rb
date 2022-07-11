class RoomsController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    rooms = Room.all
    sendRooms = []
    rooms.each do |room|
      last_message = room.messages.last
      if last_message.present?
        last_message_content = last_message.content
        last_message_created_at = last_message.created_at
      end
      data = {
        id: room.id,
        name: room.name,
        last_message: last_message_content,
        timestamp: last_message_created_at
      }
      sendRooms.push(data)
    end
    render json: sendRooms, status: :ok
  end

  def show
    room = Room.find(params[:id]).slice(:id, :name)
    render json: room, status: :ok
  end

end
