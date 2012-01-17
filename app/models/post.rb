class Post < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :parent, :class_name => "Post", :foreign_key => "post_id" 
  has_many :replies, :class_name => "Post", :foreign_key => "post_id"
  has_many :views
  has_many :viewers, :through => :views
  
  validates_presence_of :body
  
  scope :by_last_reply_time, select("posts.*, MAX(replies.created_at) as last_reply_time").joins("LEFT JOIN posts replies ON replies.post_id = posts.id").group("id").order("(CASE WHEN MAX(replies.created_at) IS NULL THEN posts.created_at ELSE MAX(replies.created_at) END) DESC")
  
  def reply?
    !parent.nil?
  end
  
end
