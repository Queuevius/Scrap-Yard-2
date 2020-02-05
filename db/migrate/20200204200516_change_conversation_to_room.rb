class ChangeConversationToRoom < ActiveRecord::Migration[5.1]
  def change
    rename_table :conversations, :rooms
  end
end
