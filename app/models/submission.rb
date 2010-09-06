class Submission < ActiveRecord::Base
  has_attached_file :upload, PAPERCLIP_OPTIONS
  belongs_to :student
  belongs_to :assignment
    
  validates_attachment_presence :upload
  validates_attachment_content_type :upload, :content_type => ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
  validates_attachment_size :upload, :less_than => 4.megabytes 
  
  validates_presence_of :student_id, :assignment_id
end
