require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase

  test "sends announcement to every student in the class" do
    course = FactoryGirl.create(:course)
    3.times do
      course.students << FactoryGirl.create(:student)
    end
    assert_difference "ActionMailer::Base.deliveries.size", 3 do
      FactoryGirl.create(:announcement, :course => course)
    end
  end

end
