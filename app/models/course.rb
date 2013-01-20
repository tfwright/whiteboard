class Course < ActiveRecord::Base

  has_many :documents, :as => :attachable
  has_many :announcements
  has_many :links
  has_many :assignments
  has_many :grades, :through => :assignments
  has_many :posts
  has_and_belongs_to_many :students, :association_foreign_key => "user_id", :join_table => "courses_users", :uniq => true
  belongs_to :professor, :foreign_key => "user_id"

  validates_presence_of :user_id, :title, :begins_on, :ends_on, :time_zone, :code
  validates_inclusion_of :time_zone, :in => ActiveSupport::TimeZone.us_zones.map(&:name)
  validates_uniqueness_of :code
  validate do
    errors.add :base, 'End date cannot precede start date' unless (begins_on.blank? || ends_on.blank?) || ends_on > begins_on
  end

  before_validation do
    self.code ||= (self.title + SecureRandom.hex(2))
  end

  def grade(student)
    grades.where(:student_id => student.id).where("score is not null").to_a.sum do |grade|
      grade.score * (grade.weight/total_weight(student))
    end
  end

  def active?
    begins_on <= Date.today && ends_on >= Date.today
  end

  private

    def total_weight(student)
      # This means weighting can be greater than 100, but there's no technical reason not to do that
      grades.where(:student_id => student.id).where("score is not null").to_a.sum(&:weight)
    end

end
