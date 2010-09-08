class Announcement < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :subject, :body, :course_id
  
  def after_create
    course.students.each do |student|
      Notifier.announcement(self, student).deliver
    end
  end
  
end
