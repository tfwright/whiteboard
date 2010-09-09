require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase

  test "shows announcement" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    get :show, :course_id => 1, :id => Factory(:announcement).id
  end
  
end
