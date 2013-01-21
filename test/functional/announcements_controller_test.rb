require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase

  test "shows announcement" do
    course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    course.students << student
    sign_in student
    get :show, :course_id => 1, :id => FactoryGirl.create(:announcement).id
  end

  test "students cannot access edit form" do
    student = FactoryGirl.create(:student)
    sign_in student
    get :edit, :course_id => 1, :id => FactoryGirl.create(:announcement).id
    assert_response :redirect
  end

  test "creates announcement" do
    professor = FactoryGirl.create(:professor)
    course = FactoryGirl.create(:course, :professor => professor)
    sign_in professor
    assert_difference "Announcement.count", 1 do
      post :create, :course_id => course.id, :announcement => FactoryGirl.attributes_for(:announcement)
    end
  end

  test "lists announcements" do
    course = FactoryGirl.create(:course)
    sign_in course.professor
    get :index, :course_id => course.id
    assert_not_nil assigns(:announcements)
  end

end
