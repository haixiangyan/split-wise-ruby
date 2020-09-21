class AddUserToTagging < ActiveRecord::Migration[6.0]
  def change
    add_reference :taggings, :user
  end
end
