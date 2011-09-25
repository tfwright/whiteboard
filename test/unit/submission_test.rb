require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  
  test "cannot be updated after assignment due date" do
    submission = Factory(:submission)
    submission.assignment.update_attribute(:due_at, 1.day.ago)
    submission.upload = fixture_file_upload('/files/syllabus.pdf', 'application/pdf')
    assert !submission.valid?
  end
  
  test "returns amalgram of submitter name and assignment name" do
    student = Factory(:student, :name => "Test")
    assignment = Factory(:assignment, :name => "Toast")
    submission = Factory(:submission, :student => student, :assignment => assignment)
    assert_equal "Test-Toast.pdf", submission.normalized_file_name
  end

end