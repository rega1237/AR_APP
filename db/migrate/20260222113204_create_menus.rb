class CreateMenus < ActiveRecord::Migration[8.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
