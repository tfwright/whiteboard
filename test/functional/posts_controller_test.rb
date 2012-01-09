require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  test "lists posts for a course" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    get :index, :course_id => course.id
    assert_not_nil(assigns(:posts))
  end
  
  test "returns new post for form" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    get :new, :course_id => course.id
    assert_not_nil(assigns(:post))
  end
  
  test "creates a post" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    assert_difference "Post.count", 1 do
      post :create, :course_id => course.id, :post => Factory.attributes_for(:post)
    end
  end
  
  test "renders form for a new post with errors" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    post :create, :course_id => course.id, :post => Factory.attributes_for(:post, :body => "")
    assert_template :new
  end
  
  test "displays a post" do
    course = Factory(:course)
    student = Factory(:student)
    course.students << student
    sign_in student
    post = Factory(:post, :course => course)
    get :show, :course_id => course.id, :id => post.id
    assert_equal(post, assigns(:post))
  end
end
