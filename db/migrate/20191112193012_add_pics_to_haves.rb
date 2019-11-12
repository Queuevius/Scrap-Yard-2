class AddPicsToHaves < ActiveRecord::Migration[5.1]
  def change
    add_column :haves, :image, :string
    add_column :haves, :price, :string
  end
end
