class Course < ActiveRecord::Base
  validates :title, :presence => true
  validates :code, :presence => true
  validates :begins_on, :presence => true
  validates :ends_on, :presence => true
  validates_uniqueness_of :code, :scope => :user_id
  validate do
    errors.add_to_base 'End date cannot precede start date' if !(begins_on.blank? || ends_on.blank?) && ends_on < begins_on
  end
end
