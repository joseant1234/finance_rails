class CreateParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :parameters do |t|
      t.integer :kind
      t.string :value

      t.timestamps
    end
  end
end
