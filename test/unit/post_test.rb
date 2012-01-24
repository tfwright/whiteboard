require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  test "returns false if user is author of post without replies" do
    user = Factory(:user)
    post = Factory(:post, :author => user)
    assert !post.new_for?(user)
  end
  
  test "returns true is user has not viewed someone else's reply to their post" do
    user = Factory(:user)
    post = Factory(:post, :author => user)
    Factory(:post, :parent => post)
    assert post.new_for?(user)
  end
  
  test "returns true if user has not viewed post authored by someone else" do
    user = Factory(:user)
    post = Factory(:post)
    assert post.new_for?(user)
  end
  
  test "returns false if user has viewed post authored by someone else" do
    user = Factory(:user)
    post = Factory(:post)
    View.create!(:user => user, :post => post)
    assert !post.new_for?(user)
  end
  
  test "return false if user has viewed all replies to their post" do
    user = Factory(:user)
    post = Factory(:post, :author => user)
    reply = Factory(:post, :parent => post)
    View.create!(:user => user, :post => reply)
    assert !post.new_for?(user)
  end
  
end