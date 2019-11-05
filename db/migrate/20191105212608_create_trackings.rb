class CreateTrackings < ActiveRecord::Migration[5.1]
  def change
    create_table :trackings do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
