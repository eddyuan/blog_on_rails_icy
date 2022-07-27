class AddUserToPosts < ActiveRecord::Migration[7.0]
  def change
    # remove null: false here to allow it to be null
    add_reference :posts, :user, foreign_key: true
  end
end
