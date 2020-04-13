class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :text
      t.references :token, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
