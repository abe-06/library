class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.integer :isbn
      t.decimal :price, precision: 5, scale: 2
      t.text :description
    end
  end
end
