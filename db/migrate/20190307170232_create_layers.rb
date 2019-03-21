class CreateLayers < ActiveRecord::Migration[5.1]
  def change
    create_table :layers do |t|
      t.string :name
      t.integer :post_id
      t.integer :creator_id
      t.text :body
      t.timestamps
    end
  end
end
