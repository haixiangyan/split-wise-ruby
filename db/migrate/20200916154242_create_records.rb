class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.integer :amount, null: false
      t.integer :category, null: false, limit: 1
      t.string :note
      t.timestamps
    end
  end
end
