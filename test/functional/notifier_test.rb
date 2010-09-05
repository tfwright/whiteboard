require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  
  test "enrollment notifier" do 
    Notifier.enrollment_notification(Factory(:student), Factory(:course))
  end
  
end
