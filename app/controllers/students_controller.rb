class StudentsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => [:index]
  before_filter :ensure_enrolled
  
  def index
    @students = @current_course.students
  end
  
  def new
    @student = Student.new
  end
  
  def enroll
    @student = Student.find_by_email(params[:student][:email]) || Student.new(params[:student].merge(:password => Devise.friendly_token))
    @student.courses << @current_course
    respond_to do |format|
      if @student.save
        Notifier.enrollment_notification(@student, @current_course).deliver
        format.html { redirect_to(course_students_path(@current_course), :notice => 'Student was successfully added.') }
        format.js { render :json => @student, :status => 200 }
      else
        format.html { render :action => :new }
        format.js { render :json => @student, :status => :unprocessable_entity }
      end
    end
  end
  
  def unenroll
    @student = Student.find(params[:id])
    @student.courses.delete(@current_course)
    redirect_to course_students_path(@current_course), :notice => "Student has been unrolled."
  end
  
  def import
    @roster = FasterCSV.table(params[:roster].path)
    @selected_column = @roster.headers.detect{|h| h.to_s.match(/email/) }
  end
  
  private 
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
  
end
