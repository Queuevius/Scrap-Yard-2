class ChangeColumnsInMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :user_id
    remove_column :messages, :body
    remove_column :messages, :conversation_id

    add_reference :messages, :room, index: true
    add_reference :messages, :user, index: true
    add_column :messages, :message, :text
  end
end
