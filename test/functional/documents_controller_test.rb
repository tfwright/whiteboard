require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase


  test "redirects to course page" do
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
  
end