require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase

  test "creates a submission" do
    student = Factory(:student)
    assignment = Factory(:assignment)
    assignment.course.students << student
    sign_in student
    assert_difference "Submission.count", 1 do
      post :create, :assignment_id => assignment.id, :course_id => assignment.course.id, :submission => Factory.attributes_for(:submission, :assignment_id => assignment.id)
    end
  end
  
  test "professor can access submission form for overdue assignments" do
    assignment = Factory(:assignment)
    sign_in assignment.course.professor
    get :new, :assignment_id => assignment.id, :course_id => assignment.course.id
    assert_response :success
  end
  
  test "professor can add submissions for overdue assigments" do
    assignment = Factory(:assignment, :due_at => Date.yesterday)
    sign_in assignment.course.professor
    assert_difference "Submission.count", 1 do
      post :create, :assignment_id => assignment.id, :course_id => assignment.course.id, :submission => Factory.attributes_for(:submission, :assignment_id => assignment.id, :student_id => Factory(:student).id)
    end
  end
  
  test "redirects professor away from new if no students need to sumbit assignment" do
    assignment = Factory(:assignment, :accepting_submissions => true)
    sign_in assignment.course.professor
    get :new, :assignment_id => assignment.id, :course_id => assignment.course.id
    assert_response :redirect
  end
  
  test "deletes submission" do
    assignment = Factory(:assignment, :accepting_submissions => true)
    submission = Factory(:submission, :assignment => assignment)
    sign_in assignment.course.professor
    assert_difference "Submission.count", -1 do
      delete :destroy, :assignment_id => assignment.id, :course_id => assignment.course.id, :id => submission.id
    end
  end
  
end
