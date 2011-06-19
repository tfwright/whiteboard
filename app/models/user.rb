class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :time_zone
  
  validates_format_of :email, :with => /^.+@.+\..+$/
  validates_uniqueness_of :email
  
  before_create :set_default_name
  
  private
  
    def set_default_name
      self.name ||= email.gsub(/@.*/, "")
    end
  
end
