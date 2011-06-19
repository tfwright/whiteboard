require 'test_helper'

class ProfessorsControllerTest < ActionController::TestCase

  test "students redirected away from new professor form" do
    sign_in Factory(:student)
    get :new
    assert_response :redirect
  end
  
  test "admins admitted to new professor form" do
    sign_in Factory(:admin)
    get :new
    assert_response :success
  end
  
end
