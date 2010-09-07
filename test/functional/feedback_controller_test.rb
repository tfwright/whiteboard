require 'test_helper'

class FeedbackControllerTest < ActionController::TestCase

  test "renders feedback form" do
    sign_in Factory(:student)
    get :new
    assert_response :success
  end
  
  test "sends feedback email" do 
    sign_in Factory(:student)
    post :deliver, :feedback => {:feeling => ":D", :summary => "This test passes!", :body => "Everything's working great!"}
    assert response.body.blank?
  end
  
end
