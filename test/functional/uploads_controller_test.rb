require 'test_helper'

class UploadsControllerTest < ActionController::TestCase


  test "redirects to course page" do
    course = Factory(:course)
    sign_in course.professor
    post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :upload => Factory.attributes_for(:upload)
    assert_redirected_to course
  end

  test "creates upload for course" do
    course = Factory(:course)
    sign_in course.professor
    assert_difference "Upload.count", 1 do
      post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :upload => Factory.attributes_for(:upload)
    end
  end
  
end
