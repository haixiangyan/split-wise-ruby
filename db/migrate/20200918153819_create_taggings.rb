class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false
      t.references :record, null: false
      t.timestamps
    end
  end
end
