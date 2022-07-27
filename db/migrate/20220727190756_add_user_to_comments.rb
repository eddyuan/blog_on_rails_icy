class AddUserToComments < ActiveRecord::Migration[7.0]
  def change
    # remove null: false here to allow it to be null
    add_reference :comments, :user, foreign_key: true
  end
end
