class Course < ActiveRecord::Base
  has_many :uploads
  
  validates :title, :presence => true
  validates :code, :presence => true
  validates :begins_on, :presence => true
  validates :ends_on, :presence => true
  validates_uniqueness_of :code, :scope => :user_id
  validate do
    errors.add :base, 'End date cannot precede start date' unless (begins_on.blank? || ends_on.blank?) || ends_on > begins_on
  end
end
