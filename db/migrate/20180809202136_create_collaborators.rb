class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :last_name
      t.references :team, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :address
      t.string :phone
      t.string :email
      t.attachment :photo

      t.timestamps
    end
  end
end
