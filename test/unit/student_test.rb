require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  test "send email after create" do
    assert_difference "ActionMailer::Base.deliveries.size", 1 do
      Factory(:student)
    end
  end

end
