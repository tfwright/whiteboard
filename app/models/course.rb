class Course < ActiveRecord::Base
  
  has_many :documents, :as => :attachable
  has_many :announcements
  has_many :links
  has_many :assignments
  has_many :grades, :through => :assignments
  has_and_belongs_to_many :students, :association_foreign_key => "user_id", :join_table => "courses_users", :uniq => true
  belongs_to :professor, :foreign_key => "user_id"
  
  validates_presence_of :user_id, :title, :begins_on, :ends_on
  validate do
    errors.add :base, 'End date cannot precede start date' unless (begins_on.blank? || ends_on.blank?) || ends_on > begins_on
  end
  
  def grade(student)
    grades.where(:student_id => student.id).where("score is not null").to_a.sum{ |g| g.score * (g.assignment.weight/total_weight(student)) }
  end
  
  def active?
    begins_on <= Date.today && ends_on >= Date.today
  end
  
  private
  
    def total_weight(student)
      grades.where(:student_id => student.id).map(&:assignment).sum(&:weight)
    end
  
end
