class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :slug
      t.string :contact_email
      t.string :contact_phone
      t.text :address
      t.string :api_token
      t.string :subscription_status
      t.date :subscription_expires_at

      t.timestamps
    end
    add_index :clients, :slug, unique: true
    add_index :clients, :api_token, unique: true
  end
end
