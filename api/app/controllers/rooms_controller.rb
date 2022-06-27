class RoomsController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    rooms = Room.all
    sendData = []
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
      sendData.push(data)
    end
    render json: sendData, status: :ok
  end

  def show
    room = Room.find(params[:id])
    data = {
      id: room.id,
      name: room.name,
    }
    render json: data, status: :ok
  end

end
