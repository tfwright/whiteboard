require 'test_helper'

class ProfessorsControllerTest < ActionController::TestCase

  test "students redirected away" do
    sign_in Factory(:student)
    get :new
    assert_response :redirect
  end
  
end
