class Professor < User
  has_many :courses, :foreign_key => "user_id"
end
