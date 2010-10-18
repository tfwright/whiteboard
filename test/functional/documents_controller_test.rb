require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase

  test "redirects to course page after creation" do
    course = Factory(:course)
    sign_in course.professor
    post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :document => Factory.attributes_for(:document)
    assert_redirected_to course
  end

  test "creates document for course" do
    course = Factory(:course)
    sign_in course.professor
    assert_difference "Document.count", 1 do
      post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :document => Factory.attributes_for(:document)
    end
  end
  
  test "students can't access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:document).id
    assert_response :redirect
  end
  
  test "updates document name" do
    course = Factory(:course)
    document = Factory(:document)
    sign_in course.professor
    put :update, :course_id => course.id, :id => document.id, :document => {:name => "New name!"}
    assert_equal "New name!", document.reload.name
  end
  
end
