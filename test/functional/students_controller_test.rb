require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  test "should display new student form" do
    course = Factory(:course)
    sign_in course.professor
    get :new, :course_id => course.id
    assert_response :success
  end
  
  test "should display a roster" do
    course = Factory(:course)
    sign_in course.professor
    post :import, :roster => fixture_file_upload('/files/roster.csv', 'text/csv'), :course_id => course.id
    assert_response :success
  end
  
  test "should create student record if it doesn't exist" do
    course = Factory(:course)
    sign_in course.professor
    assert_difference "Student.count", 1 do
      post :enroll, :student => {:email => "test@example.com"}, :course_id => course.id
    end
  end
  
  test "should list students in the course" do
    course = Factory(:course)
    sign_in course.professor
    get :index, :course_id => course.id
    assert_response :success
  end
  
  test "students cannot add students to a course" do
    course = Factory(:course)
    sign_in Factory(:student)
    get :new, :course_id => course.id
    assert_response :redirect
  end
  
  test "should send an email when a student is enrolled" do
    course = Factory(:course)
    sign_in course.professor
    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      post :enroll, :student => Factory.attributes_for(:student), :course_id => course.id
    end
  end
    
end
