class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.string :nme
      t.string :ruc
      t.string :address
      t.string :phone
      t.string :contact

      t.timestamps
    end
  end
end
