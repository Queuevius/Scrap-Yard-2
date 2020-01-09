class RenameColumnInPosts < ActiveRecord::Migration[5.1]
  def change
  	rename_column :posts, :body, :post_body
  	rename_column :tokens, :body, :token_body
  	rename_column :layers, :body, :layer_body  
  
  end
end
