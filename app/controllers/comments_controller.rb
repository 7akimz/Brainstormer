class CommentsController < ApplicationController do

  respond_to :html
  
  before_filter :get_task
  before_filter :get_comment, :except => [:index, :create]

  def index
    @comments = @task.comments
    respond_with(@task, @comment)
  end

  def new; end

  def create
    @comment = @task.comments.build(params[:task])
    flash[:notice] = "You created new comment" if @comment.save
    respond_with(@task, @comment)
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted!!"
    respond_with(@task, @comment)
  end

  private
    
    def get_comment
      @comment = params[:id].present? ? @task.comments.find(
        params[:id]) : Comment.new
    end

    def get_task
      @task = Task.find(params[:task_id]) if params[
        :task_id].present?
    end
end
