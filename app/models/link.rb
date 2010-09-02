class Link < ActiveRecord::Base
  belongs_to :course
  
  validates_presence_of :name, :description, :url, :course_id
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/ 
end
