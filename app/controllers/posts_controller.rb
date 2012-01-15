class PostsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_enrolled
  
  def index
    @posts = @current_course.posts
  end
  
  def show
    @post = @current_course.posts.find(params[:id])
    @post.replies.to_a.unshift(@post).each do |post|
      View.find_or_create_by_post_id_and_user_id(:post_id => post.id, :user_id => current_user.id)
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.course = @current_course unless @post.reply?
    @post.author = current_user
    if @post.save
      redirect_to course_posts_path(@current_course), :notice => "Post successfully added"
    else
      render :action => :new
    end
  end
  
  private
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
    
end
