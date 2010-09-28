class Grade < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  
  validates_presence_of :student_id, :assignment_id, :score
  validates_numericality_of :score, :greater_than_or_equal_to => 0
  validates_uniqueness_of :assignment_id, :scope => :student_id
end
