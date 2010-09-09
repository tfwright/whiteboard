require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "only account owner can view account" do
    student = Factory(:student)
    other_student = Factory(:student)
    sign_in other_student
    get :show, :id => student.id
    assert_response :redirect
  end
  
  test "account owner can view account" do
    student = Factory(:student)
    sign_in student
    get :show, :id => student.id.to_s
    assert_response :success
  end
  
end
