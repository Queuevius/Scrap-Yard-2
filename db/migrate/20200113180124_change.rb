class Change < ActiveRecord::Migration[5.1]
  def change
    rename_column :taggings, :tagging_id, :layer_id
  end
end
