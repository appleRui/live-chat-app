# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
3.times do |number|
  Message.create(content: "#{number}番目のメッセージです！", user_id: User.first.id)
  puts "#{number}番目のメッセージを作成しました"
end

puts "メッセージの作成が完了しました"
