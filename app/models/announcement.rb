class Announcement < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :subject, :body, :course_id
  
  after_create :send_email
  
  private
  
    def send_email
      course.students.each do |student|
        Notifier.announcement(self, student).deliver
      end
    end
  
end
