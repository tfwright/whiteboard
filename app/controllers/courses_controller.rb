class CoursesController < ApplicationController

  before_filter :set_current_course, :except => [:new, :create, :index, :join]
  before_filter :ensure_professor_or_admin, :except => [:show, :index, :join]
  before_filter :ensure_enrolled, :except => [:new, :create, :index, :join]

  skip_before_filter :authenticate_user!, :only => :join

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

  def join
    @course = Course.find_by_code(params[:code])
    @student = Student.find_by_email(params[:student][:email]) || Student.new(params[:student].merge(:password => Devise.friendly_token))
    respond_to do |format|
      format.json do
        if @course.nil?
          render json: {:error => "Invalid code"}, status: 406
        elsif !@student.save
          render json: {:error => "Invalid email"}, status: 406
        else
          @course.students << @student unless @course.students.include?(@student)
          sign_in(:user, @student)
          render json: {:location => course_url(@course)}, status: 200
        end
      end
    end
  end

  private

    def set_current_course
      @current_course ||= Course.find(params[:id])
    end

end
