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
  
  test "lists submissions" do
    assignment = Factory(:assignment)
    sign_in assignment.course.professor
    get :index, :course_id => assignment.course.id, :assignment_id => assignment.id
    assert_not_nil assigns(:submissions)
  end
  
  test "packages all assignments in a zip file" do
    assignment = Factory(:assignment)
    submission = Factory(:submission, :assignment => assignment, :upload_file_name => "test")
    sign_in assignment.course.professor
    tmpfile = Object.new
    stub(tmpfile).path { "/path" }
    stub(Tempfile).new { tmpfile }
    zipfile = Object.new
    stub(Zip::ZipOutputStream).open.returns { zipfile }
    stub(zipfile).put_next_entry
    stub(Addressable::URI).parse { "url" }
    stub(Net::HTTP).get { "file contents" }
    stub(zipfile).print
    mock(@controller).send_file("/path", anything)
    stub(@controller).render
    stub(tmpfile).close
    get :index, :course_id => assignment.course.id, :assignment_id => assignment.id, :format => "zip"
    assert_not_nil assigns(:submissions)
  end
  
end
