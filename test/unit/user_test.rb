require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "returns number of posts and their replies for a course if no views" do
    user = Factory(:user)
    course = Factory(:course)
    Factory(:post, :parent => Factory(:post, :course => course))
    assert_equal 2, user.number_of_unread_posts_in(course)
  end
  
  test "returns number of posts without views" do
    user = Factory(:user)
    course = Factory(:course)
    Factory(:post, :parent => Factory(:post, :course => course))
    View.create(:user => user, :post => Factory(:post, :course => course))
    assert_equal 2, user.number_of_unread_posts_in(course)
  end
  
  test "returns number of replies without views" do
    user = Factory(:user)
    course = Factory(:course)
    parent_post = Factory(:post, :course => course)
    child_post = Factory(:post, :parent => parent_post)
    View.create(:user => user, :post => child_post)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end
  
  test "returns number of posts not belonging to user" do
    user = Factory(:user)
    course = Factory(:course)
    Factory(:post, :parent => Factory(:post, :course => course, :author => user))
    assert_equal 1, user.number_of_unread_posts_in(course)
  end
  
  test "returns number of replies not belonging to the user" do
    user = Factory(:user)
    course = Factory(:course)
    Factory(:post, :parent => Factory(:post, :course => course), :author => user)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end
  
  test "only returns posts in given course" do
    user = Factory(:user)
    course = Factory(:course)
    Factory(:post, :course => course)
    Factory(:post)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end

end
