require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  
  test "students can't access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:assignment).id
    assert_response :redirect
  end
  
  test "updates assignment name" do
    course = Factory(:course)
    assignment = Factory(:assignment)
    sign_in course.professor
    put :update, :course_id => course.id, :id => assignment.id, :assignment => {:name => "New name!"}
    assert_equal "New name!", assignment.reload.name
  end

end
