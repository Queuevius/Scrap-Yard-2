class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :video
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
