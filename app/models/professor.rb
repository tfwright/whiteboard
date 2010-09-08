class Professor < User
  has_many :courses, :foreign_key => "user_id"
  
  validates_uniqueness_of :email
end
