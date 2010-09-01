class Upload < ActiveRecord::Base
  has_attached_file :attached, PAPERCLIP_OPTIONS
  belongs_to :course
    
  validates_attachment_presence :attached
  validates_attachment_content_type :attached, :content_type => ['application/pdf', 'application/msword']
  validates_attachment_size :attached, :less_than => 4.megabytes 
  
  validates_presence_of :name, :description
end
