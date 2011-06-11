class Post < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :content

  # Setup association for your model
  belongs_to :user

  # Setup validation for content 
  validates :content, :presence => true

  # Setup validation for user_id 
  validates :user_id, :presence => true

  
  default_scope :order => 'posts.created_at DESC'
end
