class AddHaveIdToFeeds < ActiveRecord::Migration[5.1]
  def change
    add_column :feeds, :have_id, :integer
  end
end
