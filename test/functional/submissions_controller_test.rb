require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase

  test "creates a submission" do
    student = Factory(:student)
    sign_in student
    assert_difference "Submission.count", 1 do
      post :create, :assignment_id => Factory(:assignment).id, :course_id => Factory(:course).id, :submission => Factory.attributes_for(:submission)
    end
  end
  
end
