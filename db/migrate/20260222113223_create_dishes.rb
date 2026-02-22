class CreateDishes < ActiveRecord::Migration[8.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :position
      t.boolean :is_visible
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
