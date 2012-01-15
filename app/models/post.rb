class Post < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :parent, :class_name => "Post", :foreign_key => "post_id" 
  has_many :replies, :class_name => "Post", :foreign_key => "post_id"
  has_many :views
  has_many :viewers, :through => :views
  
  validates_presence_of :body
  
  def reply?
    !parent.nil?
  end
  
end
