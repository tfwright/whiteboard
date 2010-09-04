class Student < User
  has_and_belongs_to_many :courses, :foreign_key => "user_id", :join_table => "courses_users"
end
