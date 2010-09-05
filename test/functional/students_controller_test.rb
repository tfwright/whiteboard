require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  test "should display new student form" do
    sign_in Factory(:professor)
    get :new, :course_id => Factory(:course).id
    assert_response :success
  end
  
  test "should display a roster" do
    sign_in Factory(:professor)
    post :import, :roster => fixture_file_upload('/files/roster.csv', 'text/csv'), :course_id => Factory(:course).id
    assert_response :success
  end
  
  test "should create student record if it doesn't exist" do
    sign_in Factory(:professor)
    assert_difference "Student.count", 1 do
      post :enroll, :student => {:email => "test@example.com"}, :course_id => Factory(:course).id
    end
  end
  
  test "should list students in the course" do
    sign_in Factory(:professor)
    get :index, :course_id => Factory(:course).id
    assert_response :success
  end
  
end
