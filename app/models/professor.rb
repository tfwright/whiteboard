class Professor < User
  
  has_many :courses, :foreign_key => "user_id"
  
  def teaching?(course)
    course.professor == self
  end
  
end
