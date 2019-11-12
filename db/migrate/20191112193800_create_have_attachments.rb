class CreateHaveAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :have_attachments do |t|
      t.integer :post_id
      t.string :image

      t.timestamps
    end
  end
end
