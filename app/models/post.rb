class Post < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :content

  # Setup association for your model
  belongs_to :user

  # Setup validation for content 
  validates :content, :presence => true

  # Setup validation for user_id 
  validates :user_id, :presence => true

  # This order the post whenever it is pulled from
  # the database
  default_scope :order => 'posts.created_at DESC'

  # Return posts from the users being followed by this user
  # by the help of followed_by method
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  

  private
    # This private class method get all the users post
    # that the user is following including his own posts
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships WHERE
                       follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", 
            {:user_id => user})
    end

end
