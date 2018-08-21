class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :corporate_name
      t.string :ruc
      t.string :address, null: false
      t.string :phone, null: false
      t.string :contact
      t.integer :status, default: 0, null: false
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
