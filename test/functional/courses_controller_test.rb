require 'test_helper'

class CoursesControllerTest < ActionController::TestCase

  test "students are redirected away from new course form" do
    @student = Factory(:student)
    sign_in @student
    get :new
    assert_redirected_to root_url
  end
    
end
