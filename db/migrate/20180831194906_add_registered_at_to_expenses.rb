class AddRegisteredAtToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :registered_at, :datetime
  end
end
