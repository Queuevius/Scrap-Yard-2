class CreateWants < ActiveRecord::Migration[5.1]
  def change
    create_table :wants do |t|
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
