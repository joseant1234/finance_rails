class ChangeColumnNameOfMessageToNotesToIncomes < ActiveRecord::Migration[5.1]
  def change
    rename_column :incomes, :message, :note
  end
end
