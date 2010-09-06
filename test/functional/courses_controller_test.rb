require 'test_helper'

class CoursesControllerTest < ActionController::TestCase

  test "students are redirected away from new course form" do
    student = Factory(:student)
    sign_in student
    get :new
    assert_redirected_to root_url
  end
  
  test "professors can access new course form" do
    professor = Factory(:professor)
    sign_in professor
    get :new
    assert_response :success
  end
  
  test "students not enrolled in course can't see it" do
    student = Factory(:student)
    course = Factory(:course)
    sign_in student
    get :show, :id => course.id
    assert_redirected_to courses_path
  end
  
  test "students enrolled in course can see it" do
    student = Factory(:student)
    course = Factory(:course)
    student.courses << course
    sign_in student
    get :show, :id => course.id
    assert_response :success
  end
  
  test "user doesn't see courses in which they're not enrolled" do
    enrolled_course = Factory(:course)
    unenrolled_course = Factory(:course)
    student = Factory(:student)
    enrolled_course.students << student
    sign_in student
    get :index
    assert !assigns(:courses).include?(unenrolled_course)
  end
  
  test "creates a course" do
    sign_in Factory(:professor)
    assert_difference "Course.count", 1 do
      post :create, :course => Factory.attributes_for(:course)
    end
  end
  
end
