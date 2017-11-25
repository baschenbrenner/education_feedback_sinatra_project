class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :preferred_name
      t.integer :teacher_id
      t.string :password_digest
    end
  end
end
