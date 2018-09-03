class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.integer :state, null: false, default: 0
      t.integer :source, null: false, default: 0
      t.text :description
      t.string :invoice_number
      t.string :purchase_order_number
      t.decimal :amount, precision: 10, scale: 2
      t.references :client, foreign_key: true
      t.references :country, foreign_key: true
      t.datetime :billing_at
      t.attachment :invoice_copy
      t.attachment :purchase_order
      t.references :currency, foreign_key: true
      t.text :note
      t.boolean :drawdown_seal
      t.string :reference
      t.references :team, foreign_key: true
      t.references :collaborator, foreign_key: true
      t.decimal :igv, precision: 10, scale: 2
      t.datetime :registered_at, null: false

      t.timestamps
    end
  end
end
