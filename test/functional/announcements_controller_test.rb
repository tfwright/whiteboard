require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase

  test "shows announcement" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    get :show, :course_id => 1, :id => Factory(:announcement).id
  end
  
  test "students cannot access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:announcement).id
    assert_response :redirect
  end
  
end
