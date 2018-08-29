class AddCateoryToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_reference :expenses, :category, foreign_key: true
  end
end
