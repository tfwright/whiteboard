class Student < User
  has_and_belongs_to_many :courses, :foreign_key => "user_id", :join_table => "courses_users"
  has_many :submissions
  
  validates_uniqueness_of :email
  
  def after_create
    Notifier.new_account_notification(self).deliver
  end
  
end
