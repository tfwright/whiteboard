require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  
  test "strips non alpha-numeric characters" do
    document = Factory(:document, :attached => fixture_file_upload("/files/bad file [name].pdf", "application/pdf"))
    assert_equal "bad_file__name_.pdf", document.normalized_file_name
  end

end
