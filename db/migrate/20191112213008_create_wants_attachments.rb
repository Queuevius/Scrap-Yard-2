class CreateWantsAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :wants_attachments do |t|
      t.integer :want_id
      t.string :image

      t.timestamps
    end
  end
end
