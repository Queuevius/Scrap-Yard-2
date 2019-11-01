class AddColumnInTokens < ActiveRecord::Migration[5.1]
  def change
  	add_column :tokens, :span_id, :string
  end
end
