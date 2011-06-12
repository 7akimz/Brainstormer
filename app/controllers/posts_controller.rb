class PostsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "You created a new post"
      redirect_to root_path
    else
      @feed_items = []
      render 'statics/index'
    end
  end  

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end
end
