class Student < User
  
  has_and_belongs_to_many :courses, :foreign_key => "user_id", :join_table => "courses_users"
  has_many :submissions
  has_many :grades
  
  after_create :send_confirmation_email
  
  private
  
    def send_confirmation_email
      Notifier.new_account_notification(self).deliver
    end
  
end
