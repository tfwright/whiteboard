require 'test_helper'

class GradeTest < ActiveSupport::TestCase

  test "allows blank grades" do
    FactoryGirl.create(:grade, :score => "")
  end

end
