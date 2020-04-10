class CreateDebates < ActiveRecord::Migration[5.1]
  def change
    create_table :debates do |t|
      t.text :central_argument
      t.references :token, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
