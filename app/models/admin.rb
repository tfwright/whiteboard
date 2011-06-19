class Admin < User
  def courses
    Course.order
  end
end
