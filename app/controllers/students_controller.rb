class StudentsController < ApplicationController
  
  def index
    @students = Course.find(params[:course_id]).students
  end
  
  def new
    @student = Student.new
  end
  
  def enroll
    @student = Student.find_by_email(params[:student][:email]) || Student.new(params[:student].merge(:password => Devise.friendly_token))
    @student.courses << Course.find(params[:course_id])
    respond_to do |format|
      if @student.save
        format.html { redirect_to(course_students_path(Course.find(params[:course_id])), :notice => 'Student was successfully added.') }
        format.js { render :json => @student, :status => 200 }
      else
        format.html { render :action => :new }
        format.js { render :json => @student, :status => :unprocessable_entity }
      end
    end
  end
  
  def import
    @roster = FasterCSV.table(params[:roster].path)
    @selected_column = @roster.headers.detect{|h| h.to_s.match(/email/) }
  end
  
end
