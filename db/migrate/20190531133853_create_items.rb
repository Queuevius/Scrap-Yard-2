class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :details
      t.integer :user_id
      t.string :item_type

      t.timestamps
    end
  end
end
