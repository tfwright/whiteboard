require 'test_helper'

class ProfessorsControllerTest < ActionController::TestCase

  test "students redirected away from new professor form" do
    sign_in FactoryGirl.create(:student)
    get :new
    assert_response :redirect
  end

  test "admins admitted to new professor form" do
    sign_in FactoryGirl.create(:admin)
    get :new
    assert_response :success
  end

end
