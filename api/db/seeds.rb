# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

rooms = ["gereral", "random", "info", "memory"]
rooms.each do |room|
  Room.create(name: room)
  puts "#{room}"
end

5.times do |number|
  user = User.first.id
  Message.create(content: "#{number}番目のメッセージです！", user_id: user, room_id: Room.first.id)
  puts "#{number}番目のメッセージを作成しました"
end

puts "メッセージの作成が完了しました"
