class MessagesController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    room = Room.find(params['id'])
    sort_messages = room.messages.order(:created_at)
    send_messages = sort_messages.map do |message|
      {
        id: message.id,
        user_id: message.user.id,
        name: message.user.name,
        content: message.content,
        email: message.user.email,
        created_at: message.created_at,
      }
    end

    render json: send_messages, status: :ok
  end

end
