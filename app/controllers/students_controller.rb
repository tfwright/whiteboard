class StudentsController < ApplicationController

  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => [:index]
  before_filter :ensure_enrolled

  def index
    @students = @current_course.students
  end

  def show
    @student = @current_course.students.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @student.attributes.merge(:grade => @current_course.grade(@student).round(1)) }
    end
  end

  def new
    @student = Student.new
  end

  def enroll
    @student = Student.find_by_email(params[:student][:email]) || Student.new(params[:student].merge(:password => Devise.friendly_token))
    @student.time_zone ||= @current_course.time_zone
    if @student.save
      unless @student.courses.include?(@current_course)
        @student.courses << @current_course
        Notifier.enrollment_notification(@student, @current_course).deliver
      end
      redirect_to(course_students_path(@current_course), :notice => 'Student was successfully added.')
    else
      render :action => :new
    end
  end

  def unenroll
    @student = Student.find(params[:id])
    @student.courses.delete(@current_course)
    redirect_to course_students_path(@current_course), :notice => "Student has been unrolled."
  end

  private

    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end

end
