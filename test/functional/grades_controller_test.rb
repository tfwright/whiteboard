require 'test_helper'

class GradesControllerTest < ActionController::TestCase
  
  test "doesn't show grades for other students" do
    student = Factory(:student)
    other_student = Factory(:student)
    course = Factory(:course)
    course.students << [student, other_student]
    sign_in student
    get :index, :course_id => course.id
    assert !assigns(:students).include?(other_student)
  end
  
end
