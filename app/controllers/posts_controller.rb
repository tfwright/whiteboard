class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  before_filter :set_current_course
  before_filter :ensure_enrolled
  
  def index
    @posts = @current_course.posts.by_last_reply_time.paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.json do 
        render :json => {:posts => @posts.map{|p| p.attributes.merge(:unviewed => !View.exists?(:user_id => current_user.id, :post_id => p.id), "body" => truncate(p.body, :length => 600), "url" => course_post_url(@current_course, p), "reply-count" => p.replies.count, :author => p.author)}, 
          "next-page" => @posts.all.next_page ? course_posts_url(@current_course, :page => @posts.next_page, :format => :json) : nil }
      end
    end
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
