class AddRoomIdColumnToMessage < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :room, null: true, foreign_key: true
  end
end
