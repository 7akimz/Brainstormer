class StaticsController < ApplicationController
  respond_to :html

  def index
    if user_signed_in?
      @post = Post.new 
      @feed_items = current_user.feed
    end
  end
  
end
