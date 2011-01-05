require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  
  test "students can't access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:link).id
    assert_response :redirect
  end
  
  test "creates link" do
    professor = Factory(:professor)
    course = Factory(:course, :professor => professor)
    sign_in professor
    assert_difference "Link.count", 1 do
      post :create, :course_id => course.id, :link => Factory.attributes_for(:link)
    end
  end
  
end
