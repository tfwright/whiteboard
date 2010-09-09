require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  
  test "students can't access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:link).id
    assert_response :redirect
  end
  
end
