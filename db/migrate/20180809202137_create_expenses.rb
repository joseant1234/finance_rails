class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :state, null: false, default: 0
      t.integer :source, null: false, default: 0
      t.boolean :with_fee
      t.text :description
      t.string :document_number
      t.decimal :amount, precision: 6, scale: 2
      t.decimal :igv_amount, precision: 6, scale: 2
      t.references :provider, foreign_key: true
      t.references :country, foreign_key: true
      t.datetime :billing_at
      t.datetime :transaction_at

      t.timestamps
    end
  end
end
