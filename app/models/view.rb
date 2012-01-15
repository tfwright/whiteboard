class View < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :post
  
  validates_presence_of :post_id, :user_id
  validates_uniqueness_of :post_id, :scope => :user_id
  
end
