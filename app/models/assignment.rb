class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :uploads, :as => :attachable
  has_many :grades
  
  validates_presence_of :name, :description, :due_at, :course_id
  validates_datetime :due_at, :after => DateTime.now
end
