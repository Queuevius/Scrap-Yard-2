class RenameColumnInTokens < ActiveRecord::Migration[5.1]
  def change
  	change_column :tokens, :type, :token_type, :string
  end
end
