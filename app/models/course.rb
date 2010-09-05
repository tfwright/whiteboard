class Course < ActiveRecord::Base
  has_many :uploads
  has_many :announcements
  has_many :links
  has_many :assignments
  has_and_belongs_to_many :students, :association_foreign_key => "user_id", :join_table => "courses_users", :uniq => true
  belongs_to :professor, :foreign_key => "user_id"
  
  validates_presence_of :user_id, :title, :code, :begins_on, :ends_on
  validates_uniqueness_of :code, :scope => :user_id
  validate do
    errors.add :base, 'End date cannot precede start date' unless (begins_on.blank? || ends_on.blank?) || ends_on > begins_on
  end
end
