require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test "returns average of all a given student's grades in course" do
    course = Factory(:course)
    student = Factory(:student)
    2.times do |n|
      assignment = Factory(:assignment, :course => course)
      course.assignments << assignment
      Factory(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assert_equal 30, course.grade(student)
  end
  
  test "returns weighted average of a given student's grade in course" do
    course = Factory(:course)
    student = Factory(:student)
    2.times do |n|
      assignment = Factory(:assignment, :course => course, :weight => 20*(n+1)+20) # 40/60
      course.assignments << assignment
      Factory(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assert_equal 32.0, course.grade(student)
  end
  
  test "ignores ungraded assignments" do
    course = Factory(:course)
    student = Factory(:student)
    2.times do |n|
      assignment = Factory(:assignment, :course => course, :weight => 20)
      course.assignments << assignment
      Factory(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assignment = Factory(:assignment, :course => course, :weight => 60)
    course.assignments << assignment
    assert_equal 30.0, course.grade(student)
  end
  
  test "returns true for an active course" do
    course = Factory(:course, :begins_on => Date.today-1, :ends_on => Date.today+1)
    assert course.active?
  end
  
  test "should be active if ends today" do
    course = Factory(:course, :begins_on => Date.today-5, :ends_on => Date.today)
    assert course.active?
  end
  
  test "should be active if begins today" do
    course = Factory(:course, :begins_on => Date.today, :ends_on => Date.today+5)
    assert course.active?
  end
  
end
