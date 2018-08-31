class DeleteIgvAmountToIncomes < ActiveRecord::Migration[5.1]
  def change
    remove_column :incomes, :igv_amount
  end
end
