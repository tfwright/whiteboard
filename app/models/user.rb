class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :time_zone
  
  has_many :posts
  
  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates_uniqueness_of :email
  
  before_create :set_default_name
  
  def number_of_unread_posts_in(course)
    posts = course.posts.map(&:id)
    replies = course.posts.map(&:replies).flatten.map(&:id)
    viewed_posts = View.where(:user_id => self.id).map(&:post).map(&:id)
    ((posts+replies) - viewed_posts).size
  end
  
  private
  
    def set_default_name
      self.name ||= email.gsub(/@.*/, "")
    end
  
end
