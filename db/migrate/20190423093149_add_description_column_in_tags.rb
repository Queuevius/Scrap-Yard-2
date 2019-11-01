class AddDescriptionColumnInTags < ActiveRecord::Migration[5.1]
  def change
  	add_column :tags, :tag_body, :text
  end
end
