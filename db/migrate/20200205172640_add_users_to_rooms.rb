class AddUsersToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :sender_id, :integer
    add_column :rooms, :reciever_id, :integer
  end
end
