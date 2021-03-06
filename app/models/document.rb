class Document < ActiveRecord::Base
  has_attached_file :attached, PAPERCLIP_OPTIONS
  belongs_to :attachable, :polymorphic => true
    
  validates_attachment_presence :attached
  validates_attachment_content_type :attached, :content_type => ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'],
    :message => "is not an acceptable file type."
  validates_attachment_size :attached, :less_than => 10.megabytes 
  
  validates_presence_of :name, :description, :attachable_id
  
end
