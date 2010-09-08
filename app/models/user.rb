class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  validates_format_of :email, :with => /^.+@.+\..+$/
  
  def before_create
    self.name ||= email.gsub(/@.*/, "")
  end
  
end
