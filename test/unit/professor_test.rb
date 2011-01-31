require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
  
  test "returns true when course belongs to professor" do
    course = Factory(:course)
    assert course.professor.teaching?(course)
  end

end
