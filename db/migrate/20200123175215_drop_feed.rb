class DropFeed < ActiveRecord::Migration[5.1]
  def change
    drop_table :feed
  end
end
