class AddIgvToIncomes < ActiveRecord::Migration[5.1]
  def change
    add_column :incomes, :igv, :decimal, precision: 10, scale: 2
  end
end
