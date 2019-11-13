class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.integer :post_id
      t.string :post_type

      t.timestamps
    end
  end
end
