require 'test_helper'

class GradesControllerTest < ActionController::TestCase
  
  test "doesn't show grades for other students" do
    student = Factory(:student)
    other_student = Factory(:student)
    course = Factory(:course)
    course.students << [student, other_student]
    sign_in student
    get :index, :course_id => course.id
    assert !assigns(:students).include?(other_student)
  end
  
  test "returns json error if a non professor submits a grade form" do
    student = Factory(:student)
    course = Factory(:course)
    assignment = Factory(:assignment)
    course.students << student
    course.assignments << assignment
    sign_in student
    post :create, :course_id => course.id, :student_id => student.id, :assignment_id => assignment.id, :score => 100, :format => :json
    assert_response :forbidden
  end
  
  test "renders edit form" do
    course = Factory(:course)
    assignment = Factory(:assignment, :course => course)
    grade = Factory(:grade, :assignment => assignment)
    sign_in course.professor
    get :edit, :course_id => course.id, :id => grade.id
    assert_response :success
  end
  
  test "redirects to student page" do
    course = Factory(:course)
    assignment = Factory(:assignment, :course => course)
    grade = Factory(:grade, :assignment => assignment)
    sign_in course.professor
    put :update, :course_id => course.id, :id => grade.id, :grade => Factory.attributes_for(:grade)
    assert_redirected_to course_student_url(course, grade.student)
  end
  
end
