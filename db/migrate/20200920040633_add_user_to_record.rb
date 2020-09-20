class AddUserToRecord < ActiveRecord::Migration[6.0]
  def change
    add_reference :records, :user
  end
end
