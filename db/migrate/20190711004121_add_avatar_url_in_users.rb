class AddAvatarUrlInUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :profiles, :avatar_url , :string
  end
end
