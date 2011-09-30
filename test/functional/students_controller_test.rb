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
  
  test "should handle a badly formed roster gracefully" do
    course = Factory(:course)
    sign_in course.professor
    post :import, :roster => fixture_file_upload('/files/syllabus.pdf', 'text/csv'), :course_id => course.id
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
  
  test "sends 2 emails when a new student is enrolled" do
    course = Factory(:course)
    sign_in course.professor
    assert_difference "ActionMailer::Base.deliveries.size", 2 do
      post :enroll, :student => Factory.attributes_for(:student), :course_id => course.id
    end
  end
  
  test "does not send email if a student is already enrolled" do
    course = Factory(:course)
    student = Factory(:student)
    student.courses << course
    sign_in course.professor
    assert_no_difference "ActionMailer::Base.deliveries.size" do
      post :enroll, :student => {:email => student.email}, :course_id => course.id
    end
  end
  
  test "removes student from course" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in course.professor
    assert_difference "student.courses.count", -1 do
      delete :unenroll, :id => student.id, :course_id => course.id
    end 
  end
  
  test "sets new students time zone to course time zone by default" do
    course = Factory(:course, :time_zone => "Indiana (East)")
    sign_in course.professor
    post :enroll, :student => {:email => "test@example.com"}, :course_id => course.id
    assert_equal "Indiana (East)", assigns(:student).time_zone
  end
  
end
