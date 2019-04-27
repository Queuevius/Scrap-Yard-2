class AddCreatorIdToTags < ActiveRecord::Migration[5.1]
  def change
  	add_column :tags, :creator_id, :integer
  end
end
