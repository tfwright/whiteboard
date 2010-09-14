class CoursesController < ApplicationController
  
  before_filter :set_current_course, :except => [:new, :create, :index]
  before_filter :ensure_professor_or_admin, :except => [:show, :index]
  before_filter :ensure_enrolled, :except => [:new, :create, :index]
  
  # GET /courses
  # GET /courses.xml
  def index
    @courses = current_user.courses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
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

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private 
  
    def set_current_course
      @current_course ||= Course.find(params[:id])
    end
  
end
