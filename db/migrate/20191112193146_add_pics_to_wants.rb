class AddPicsToWants < ActiveRecord::Migration[5.1]
  def change
    add_column :wants, :image, :string
    add_column :wants, :price, :string
  end
end
