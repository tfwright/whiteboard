require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  
  test "cannot be updated after assignment due date" do
    submission = Factory(:submission)
    submission.assignment.update_attribute(:due_at, 1.day.ago)
    submission.upload = fixture_file_upload('/files/syllabus.pdf', 'application/pdf')
    assert !submission.valid?
  end

end