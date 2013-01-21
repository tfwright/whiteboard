require 'test_helper'

class LinksControllerTest < ActionController::TestCase

  test "students can't access edit form" do
    student = FactoryGirl.create(:student)
    sign_in student
    get :edit, :course_id => 1, :id => FactoryGirl.create(:link).id
    assert_response :redirect
  end

  test "creates link" do
    professor = FactoryGirl.create(:professor)
    course = FactoryGirl.create(:course, :professor => professor)
    sign_in professor
    assert_difference "Link.count", 1 do
      post :create, :course_id => course.id, :link => FactoryGirl.attributes_for(:link)
    end
  end

end
