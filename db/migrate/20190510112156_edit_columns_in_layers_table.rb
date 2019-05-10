class EditColumnsInLayersTable < ActiveRecord::Migration[5.1]
  def change
  	rename_column :layers, :post_id, :layerable_id
  	add_column :layers, :layerable_type, :string
  	add_column :taggings, :layer_id, :integer
  end
end
