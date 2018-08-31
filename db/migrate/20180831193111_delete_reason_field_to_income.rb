class DeleteReasonFieldToIncome < ActiveRecord::Migration[5.1]
  def change
    remove_column :incomes, :reason
  end
end
