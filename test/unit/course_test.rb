require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test "returns average of all a given student's grades in course" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    2.times do |n|
      assignment = FactoryGirl.create(:assignment, :course => course)
      course.assignments << assignment
      FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assert_equal 30, course.grade(student)
  end

  test "returns weighted average of a given student's grade in course" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    2.times do |n|
      assignment = FactoryGirl.create(:assignment, :course => course, :weight => 20*(n+1)+20) # 40/60
      course.assignments << assignment
      FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assert_equal 32.0, course.grade(student)
  end

  test "ignores ungraded assignments" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    2.times do |n|
      assignment = FactoryGirl.create(:assignment, :course => course, :weight => 20)
      course.assignments << assignment
      FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assignment = FactoryGirl.create(:assignment, :course => course, :weight => 60)
    course.assignments << assignment
    assert_equal 30.0, course.grade(student)
  end

  test "ignores assignments with unscored grades" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    2.times do |n|
      assignment = FactoryGirl.create(:assignment, :course => course, :weight => 20)
      course.assignments << assignment
      FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => 20*(n+1)) # 20, 40
    end
    assignment = FactoryGirl.create(:assignment, :course => course, :weight => 60)
    FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => "")
    course.assignments << assignment
    assert_equal 30.0, course.grade(student)
  end

  test "uses grade weight if set" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    2.times do |n|
      assignment = FactoryGirl.create(:assignment, :course => course, :weight => 20*(n+1)+20) # 40/60
      course.assignments << assignment
      FactoryGirl.create(:grade, :student => student, :assignment => assignment, :score => 20*(n+1), :weight => 50) # 20, 40
    end
    assert_equal 30.0, course.grade(student)
  end

  test "returns true for an active course" do
    course = FactoryGirl.create(:course, :begins_on => Date.today-1, :ends_on => Date.today+1)
    assert course.active?
  end

  test "should be active if ends today" do
    course = FactoryGirl.create(:course, :begins_on => Date.today-5, :ends_on => Date.today)
    assert course.active?
  end

  test "should be active if begins today" do
    course = FactoryGirl.create(:course, :begins_on => Date.today, :ends_on => Date.today+5)
    assert course.active?
  end

end
