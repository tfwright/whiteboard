class Announcement < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :subject, :body, :course_id
end
