class MessagesController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    room = Room.find(params['id'])
    messages = room.messages.order(:created_at)
    messages_array = messages.map do |message|
      {
        id: message.id,
        user_id: message.user.id,
        name: message.user.name,
        content: message.content,
        email: message.user.email,
        created_at: message.created_at,
        likes: message.likes.map { |like| { id: like.id, email: like.user.email }  }
      }
    end

    render json: messages_array, status: :ok
  end

end
