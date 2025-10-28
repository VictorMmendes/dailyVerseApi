class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.date :publication_date

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :author
  end
end
