class CreateFees < ActiveRecord::Migration[5.1]
  def change
    create_table :fees do |t|
      t.references :expense, foreign_key: true
      t.date :planned_payment_at
      t.date :transaction_at
      t.float :amount, null: false
      t.attachment :document

      t.timestamps
    end
  end
end
