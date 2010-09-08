require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  
  test "sends announcement to every student in the class" do
    course = Factory(:course)
    3.times do
      course.students << Factory(:student)
    end
    assert_difference "ActionMailer::Base.deliveries.size", 3 do
      Factory(:announcement, :course => course)
    end
  end
  
end
