class ChangePostIdToHaveId < ActiveRecord::Migration[5.1]
  def change
    rename_column :have_attachments, :post_id, :have_id
  end
end
