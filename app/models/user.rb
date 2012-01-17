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
    Post.count_by_sql("SELECT COUNT(*) FROM posts 
      WHERE (posts.course_id = #{course.id} OR posts.id IN (SELECT posts.id from posts INNER JOIN posts parents ON posts.post_id = parents.id AND parents.course_id = #{course.id}))
        AND posts.id NOT IN (SELECT posts.id FROM posts INNER JOIN views ON views.post_id = posts.id and views.user_id = #{self.id}) AND posts.user_id != #{self.id}")
  end
  
  private
  
    def set_default_name
      self.name ||= email.gsub(/@.*/, "")
    end
  
end
