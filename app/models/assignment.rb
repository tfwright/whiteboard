class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :uploads, :as => :attachable
  has_many :grades
  has_many :submissions
  
  validates_presence_of :name, :description, :course_id
  validates_presence_of :due_at, :if => Proc.new { |assignment| assignment.accepting_submissions? }
  validates_datetime :due_at, :after => DateTime.now, :if => Proc.new { |assignment| assignment.accepting_submissions? }
  
  scope :written, lambda {
    where(:accepting_submissions => true)
  }
end
