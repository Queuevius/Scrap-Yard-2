class CreateHaves < ActiveRecord::Migration[5.1]
  def change
    create_table :haves do |t|
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
