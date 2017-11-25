class Teacher <ActiveRecord::Base
  has_many :students
  has_many :feedbacks, through :students
end
