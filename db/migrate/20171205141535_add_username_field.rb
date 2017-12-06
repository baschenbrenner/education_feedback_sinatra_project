class AddUsernameField < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :username, :string
  end
end
