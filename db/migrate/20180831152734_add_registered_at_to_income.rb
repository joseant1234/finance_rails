class AddRegisteredAtToIncome < ActiveRecord::Migration[5.1]
  def change
    add_column :incomes, :registered_at, :datetime
  end
end
