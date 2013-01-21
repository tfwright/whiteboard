require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "returns false if user is author of post without replies" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, :author => user)
    assert !post.new_for?(user)
  end

  test "returns true is user has not viewed someone else's reply to their post" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, :author => user)
    FactoryGirl.create(:post, :parent => post)
    assert post.new_for?(user)
  end

  test "returns true if user has not viewed post authored by someone else" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    assert post.new_for?(user)
  end

  test "returns false if user has viewed post authored by someone else" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    View.create!(:user => user, :post => post)
    assert !post.new_for?(user)
  end

  test "return false if user has viewed all replies to their post" do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, :author => user)
    reply = FactoryGirl.create(:post, :parent => post)
    View.create!(:user => user, :post => reply)
    assert !post.new_for?(user)
  end

end