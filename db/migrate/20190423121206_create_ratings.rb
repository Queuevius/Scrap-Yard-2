class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
    	t.integer :score 
    	t.integer :rateable_id 
    	t.string :rateable_type 
    	t.integer :creator_id
      t.timestamps
    end
  end
end
