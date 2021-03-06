require 'test_helper'

class CoursesControllerTest < ActionController::TestCase

  test "students are redirected away from new course form" do
    student = FactoryGirl.create(:student)
    sign_in student
    get :new
    assert_redirected_to root_url
  end

  test "professors can access new course form" do
    professor = FactoryGirl.create(:professor)
    sign_in professor
    get :new
    assert_response :success
  end

  test "students not enrolled in course can't see it" do
    student = FactoryGirl.create(:student)
    course = FactoryGirl.create(:course)
    sign_in student
    get :show, :id => course.id
    assert_redirected_to courses_path
  end

  test "students enrolled in course can see it" do
    student = FactoryGirl.create(:student)
    course = FactoryGirl.create(:course)
    student.courses << course
    sign_in student
    get :show, :id => course.id
    assert_response :success
  end

  test "user doesn't see courses in which they're not enrolled" do
    enrolled_course = FactoryGirl.create(:course)
    unenrolled_course = FactoryGirl.create(:course)
    student = FactoryGirl.create(:student)
    enrolled_course.students << student
    sign_in student
    get :index
    assert !assigns(:courses).include?(unenrolled_course)
  end

  test "creates a course" do
    sign_in FactoryGirl.create(:professor)
    assert_difference "Course.count", 1 do
      post :create, :course => FactoryGirl.attributes_for(:course)
    end
  end

  test "destroys a course" do
    course = FactoryGirl.create(:course)
    sign_in course.professor
    assert_difference "Course.count", -1 do
      post :destroy, :id => course.id
    end
  end

  test "creates the student" do
    course = FactoryGirl.create(:course, code: "test")
    assert_difference "Student.count", 1 do
      post :join, student: {email: "new-student@example.com"}, code: "test", format: "json"
    end
  end

  test "adds student to the course" do
    course = FactoryGirl.create(:course, code: "test")
    assert_difference "course.students.count", 1 do
      post :join, student: {email: "new-student@example.com"}, code: "test", format: "json"
    end
  end

  test "doesn't create new student" do
    course = FactoryGirl.create(:course, code: "test")
    FactoryGirl.create(:student, email: "new-student@example.com")
    assert_no_difference "Student.count" do
      post :join, student: {email: "new-student@example.com"}, code: "test", format: "json"
    end
  end

  test "does not add the student if the code is incorrect" do
    course = FactoryGirl.create(:course, code: "test")
    assert_no_difference "course.students.count" do
      put :join, student: {email: "new-student@example.com"}, code: "wrong-code", format: "json"
    end
  end

  test "sets new students time zone to course as default" do
    course = FactoryGirl.create(:course, code: "test")
    post :join, student: {email: "new-student@example.com"}, code: "test", format: "json"
    assert_equal course.time_zone, Student.find_by_email("new-student@example.com").time_zone
  end

end
