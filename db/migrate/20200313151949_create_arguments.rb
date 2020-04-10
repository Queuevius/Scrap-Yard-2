class CreateArguments < ActiveRecord::Migration[5.1]
  def change
    create_table :arguments do |t|
      t.text :text
      t.string :argument_type
      t.references :debate, foreign_key: true

      t.timestamps
    end
  end
end
