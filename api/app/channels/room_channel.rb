class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # unsubscribed is a method that is called when a connection is disconnected. In this case, no action is taken when the connection is disconnected. We leave the empty method as it is.
  end

  def receive(data)
    # The receive method is called each time a user types a message into the chat and the message data is received.
    user = User.find_by(email: data['email'])
    
    if message = Message.create(content: data['message'], user_id: user.id)
      ActionCable.server.broadcast 'room_channel', { message: data['message'], name: user.name, created_at: message.created_at }
    end
  end
end
