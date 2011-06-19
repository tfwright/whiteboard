require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase

  test "shows announcement" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    get :show, :course_id => 1, :id => Factory(:announcement).id
  end
  
  test "students cannot access edit form" do
    student = Factory(:student)
    sign_in student
    get :edit, :course_id => 1, :id => Factory(:announcement).id
    assert_response :redirect
  end
  
  test "creates announcement" do
    professor = Factory(:professor)
    course = Factory(:course, :professor => professor)
    sign_in professor
    assert_difference "Announcement.count", 1 do
      post :create, :course_id => course.id, :announcement => Factory.attributes_for(:announcement)
    end
  end
  
  test "lists announcements" do
    course = Factory(:course)
    sign_in course.professor
    get :index, :course_id => course.id
    assert_not_nil assigns(:announcements)
  end
  
end
