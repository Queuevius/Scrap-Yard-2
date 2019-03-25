class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :type
      t.integer :creator_id
      t.text :body
      t.integer :post_id
      t.integer :layer_id

      t.timestamps
    end
  end
end
