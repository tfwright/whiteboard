require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase

  test "creates a submission" do
    student = Factory(:student)
    assignment = Factory(:assignment)
    assignment.course.students << student
    sign_in student
    assert_difference "Submission.count", 1 do
      post :create, :assignment_id => assignment.id, :course_id => assignment.course.id, :submission => Factory.attributes_for(:submission, :assignment => assignment)
    end
  end
  
end
