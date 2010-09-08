class Admin < User
  def courses
    Course.all
  end
end
