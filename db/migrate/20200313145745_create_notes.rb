class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :hypertext
      t.text :note
      t.references :token, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
