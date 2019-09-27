class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :isbn
      t.decimal :price, precision: 4, scale: 2
      t.text :description
      t.integer :quantity
    end
  end
end
