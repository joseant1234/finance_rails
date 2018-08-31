class DeleteExpirationAtToIncomes < ActiveRecord::Migration[5.1]
  def change
    remove_column :incomes, :expiration_at
  end
end
