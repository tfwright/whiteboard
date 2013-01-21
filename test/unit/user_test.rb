require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "returns number of posts and their replies for a course if no views" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    FactoryGirl.create(:post, :parent => FactoryGirl.create(:post, :course => course))
    assert_equal 2, user.number_of_unread_posts_in(course)
  end

  test "returns number of posts without views" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    FactoryGirl.create(:post, :parent => FactoryGirl.create(:post, :course => course))
    View.create(:user => user, :post => FactoryGirl.create(:post, :course => course))
    assert_equal 2, user.number_of_unread_posts_in(course)
  end

  test "returns number of replies without views" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    parent_post = FactoryGirl.create(:post, :course => course)
    child_post = FactoryGirl.create(:post, :parent => parent_post)
    View.create(:user => user, :post => child_post)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end

  test "returns number of posts not belonging to user" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    FactoryGirl.create(:post, :parent => FactoryGirl.create(:post, :course => course, :author => user))
    assert_equal 1, user.number_of_unread_posts_in(course)
  end

  test "returns number of replies not belonging to the user" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    FactoryGirl.create(:post, :parent => FactoryGirl.create(:post, :course => course), :author => user)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end

  test "only returns posts in given course" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    FactoryGirl.create(:post, :course => course)
    FactoryGirl.create(:post)
    assert_equal 1, user.number_of_unread_posts_in(course)
  end

end
