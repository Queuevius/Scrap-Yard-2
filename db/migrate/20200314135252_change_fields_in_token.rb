class ChangeFieldsInToken < ActiveRecord::Migration[5.1]
  def change
    rename_column :tokens, :creator_id, :user_id
    remove_column :tokens, :span_id, :string
    remove_column :tokens, :layer_id, :integer
    remove_column :tokens, :token_body, :text
  end
end
