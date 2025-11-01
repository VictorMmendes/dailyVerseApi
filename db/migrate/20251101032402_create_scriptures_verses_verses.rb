class CreateScripturesVersesVerses < ActiveRecord::Migration[8.1]
  def change
    create_table :verses do |t|
      t.text :content
      t.string :reference

      t.timestamps
    end
  end
end
