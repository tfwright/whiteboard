require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase

  test "redirects to course page after creation" do
    course = FactoryGirl.create(:course)
    sign_in course.professor
    post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :document => FactoryGirl.attributes_for(:document)
    assert_redirected_to course
  end

  test "creates document for course" do
    course = FactoryGirl.create(:course)
    sign_in course.professor
    assert_difference "Document.count", 1 do
      post :create, :course_id => course.id, :attachable => {:attachable_id => course.id, :attachable_type => "Course"}, :document => FactoryGirl.attributes_for(:document)
    end
  end

  #test "students can't access edit form" do
  #  student = FactoryGirl.create(:student)
  #  sign_in student
  #  get :edit, :course_id => 1, :id => FactoryGirl.create(:document).id
  #  assert_response :redirect
  #end
  #
  #test "updates document name" do
  #  course = FactoryGirl.create(:course)
  #  document = FactoryGirl.create(:document)
  #  sign_in course.professor
  #  put :update, :course_id => course.id, :id => document.id, :document => {:name => "New name!"}
  #  assert_equal "New name!", document.reload.name
  #end

end
