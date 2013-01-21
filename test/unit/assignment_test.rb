require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase

  test "has an even weight by default" do
    course = FactoryGirl.create(:course)
    2.times do
      course.assignments << FactoryGirl.create(:assignment, :course => course, :weight => nil)
    end
    assert course.assignments.all?{ |a| a.weight == 50 }
  end

  test "returns true if given student has turned in assignment" do
    assignment = FactoryGirl.create(:assignment)
    student = FactoryGirl.create(:student)
    FactoryGirl.create(:submission, :student => student, :assignment => assignment)
    assert assignment.submitted?(student)
  end

  test "returns false if given student has not turned in assignment" do
    assignment = FactoryGirl.create(:assignment)
    student = FactoryGirl.create(:student)
    assert !assignment.submitted?(student)
  end

end
