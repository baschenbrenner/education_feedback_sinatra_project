class Teacher <ActiveRecord::Base
  has_many :students
  has_many :feedbacks, through: :students
  has_secure_password
  validates :username, uniqueness: true
end
