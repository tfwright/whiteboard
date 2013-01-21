require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  test "enrollment notifier" do
    Notifier.enrollment_notification(FactoryGirl.create(:student), FactoryGirl.create(:course))
  end

  test "nwe account notifier" do
    Notifier.new_account_notification(FactoryGirl.create(:student))
  end

end
