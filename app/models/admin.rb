class Admin < User
  
  validates_uniqueness_of :email
  
  def courses
    Course.all
  end
end
