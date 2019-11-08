class CreatePics < ActiveRecord::Migration[5.1]
  def change
    create_table :pics do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
