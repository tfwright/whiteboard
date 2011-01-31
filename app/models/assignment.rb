class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :uploads, :as => :attachable
  has_many :grades
  has_many :submissions
  
  validates_presence_of :name, :description, :course_id
  validates_presence_of :due_at, :if => Proc.new { |assignment| assignment.accepting_submissions? }
  
  scope :written, lambda { where(:accepting_submissions => true) }
  scope :active, lambda { where("due_at > ?", Time.zone.now) }
  
  def weight
    super || (100.0 - course.assignments.sum(:weight))/course.assignments.count
  end
  
end
