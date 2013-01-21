require 'test_helper'

class FeedbackControllerTest < ActionController::TestCase

  test "renders feedback form" do
    sign_in FactoryGirl.create(:student)
    get :new
    assert_response :success
  end

  test "sends feedback email" do
    sign_in FactoryGirl.create(:student)
    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      post :deliver, :feedback => {:feeling => ":D", :summary => "This test passes!", :body => "Everything's working great!"}
    end
  end

end
