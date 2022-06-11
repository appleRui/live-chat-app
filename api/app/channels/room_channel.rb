class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    return nil
  end

  def receive(data)
    user = User.find_by(email: data['email'])
    if message = Message.create!(content: data['message'], user_id: user.id, room_id: data['room_id'])
      ActionCable.server.broadcast 'room_channel', { message: data['message'], name: user.name, created_at: message.created_at }
    end
  end
end
