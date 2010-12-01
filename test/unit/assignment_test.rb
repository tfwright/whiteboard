require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  
  test "has an even weight by default" do
    course = Factory(:course)
    2.times do
      course.assignments << Factory(:assignment, :course => course, :weight => nil)
    end
    assert course.assignments.all?{ |a| a.weight == 50 }
  end
  
end
