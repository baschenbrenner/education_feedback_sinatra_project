class RemoveUserNameField < ActiveRecord::Migration[5.1]
  def change
    remove_column :teachers, :user_name, :string
  end
end
