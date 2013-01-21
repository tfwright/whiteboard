require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase

  test "students can't access edit form" do
    student = FactoryGirl.create(:student)
    sign_in student
    get :edit, :course_id => 1, :id => FactoryGirl.create(:assignment).id
    assert_response :redirect
  end

  test "updates assignment name" do
    course = FactoryGirl.create(:course)
    assignment = FactoryGirl.create(:assignment)
    sign_in course.professor
    put :update, :course_id => course.id, :id => assignment.id, :assignment => {:name => "New name!"}
    assert_equal "New name!", assignment.reload.name
  end

  test "deletes assignment" do
    course = FactoryGirl.create(:course)
    assignment = FactoryGirl.create(:assignment)
    sign_in course.professor
    assert_difference "Assignment.count", -1 do
      delete :destroy, :course_id => course.id, :id => assignment.id
    end
  end

end
