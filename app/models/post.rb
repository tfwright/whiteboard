class Post < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :parent, :class_name => "Post", :foreign_key => "post_id" 
  has_many :replies, :class_name => "Post", :foreign_key => "post_id"
  has_many :views
  has_many :viewers, :through => :views
  
  validates_presence_of :body
  
  scope :by_last_reply_time, select("posts.*, MAX(replies.created_at) as last_reply_time").joins("LEFT JOIN posts replies ON replies.post_id = posts.id").group("posts.id, posts.course_id, posts.user_id, posts.post_id, posts.body, posts.created_at, posts.updated_at").order("(CASE WHEN MAX(replies.created_at) IS NULL THEN posts.created_at ELSE MAX(replies.created_at) END) DESC")
  
  def reply?
    !parent.nil?
  end
  
  def new_for?(user)
    replies.unshift(self).any? do |post|  
      post.author != user &&
      !View.exists?(:user_id => user.id, :post_id => post.id)
    end
  end
  
end
