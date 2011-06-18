require 'test_helper'

class GradeTest < ActiveSupport::TestCase

  test "allows blank grades" do
    Factory(:grade, :score => "")
  end
  
end
