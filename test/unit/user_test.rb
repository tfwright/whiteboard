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

end
