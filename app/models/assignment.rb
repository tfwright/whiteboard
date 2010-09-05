class Assignment < ActiveRecord::Base
  belongs_to :course
  
  validates_presence_of :name, :description, :due_at, :course_id
  validates_datetime :due_at, :after => DateTime.now
end