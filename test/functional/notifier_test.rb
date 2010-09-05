require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  
  test "enrollment notifier" do 
    Notifier.enrollment_notification(Factory(:student), Factory(:course))
  end
  
  test "nwe account notifier" do 
    Notifier.new_account_notification(Factory(:student))
  end
  
end
