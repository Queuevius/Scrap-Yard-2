class ChangeColumnsOnConversations < ActiveRecord::Migration[5.1]
  def change
    remove_column :conversations, :sender_id
    remove_column :conversations, :recipient_id

    add_column :conversations, :name, :string, unique: true;
  end
end
