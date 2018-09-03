class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :state, null: false, default: 0
      t.integer :source, null: false, default: 0
      t.boolean :with_fee
      t.text :description
      t.string :document_number
      t.decimal :amount, precision: 10, scale: 2
      t.decimal :igv_amount, precision: 10, scale: 2
      t.references :provider, foreign_key: true
      t.references :country, foreign_key: true
      t.datetime :planned_payment_at
      t.datetime :transaction_at
      t.boolean :with_fee, default: false
      t.string :account_number
      t.string :cci
      t.string :contact_email
      t.string :place_of_delivery
      t.datetime :delivery_at
      t.attachment :transaction_document
      t.integer :payment_type, null: false, default: 0
      t.references :bank, foreign_key: true
      t.references :currency, foreign_key: true
      t.datetime :expiration_at
      t.references :team, foreign_key: true
      t.references :collaborator, foreign_key: true
      t.datetime :issue_at
      t.datetime :registered_at, null: false
      t.decimal :remaining_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
