class CoursesController < ApplicationController
  
  before_filter :set_current_course, :except => [:new, :create, :index]
  before_filter :ensure_professor_or_admin, :except => [:show, :index]
  before_filter :ensure_enrolled, :except => [:new, :create, :index]
  
  def index
    @courses = current_user.courses.order("begins_on DESC")
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(params[:course].merge(:user_id => current_user.id))
    if @course.save
      redirect_to(@course, :notice => 'Course was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      redirect_to(@course, :notice => 'Course was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end
  
  private 
  
    def set_current_course
      @current_course ||= Course.find(params[:id])
    end
  
end
