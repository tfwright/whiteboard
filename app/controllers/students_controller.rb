class StudentsController < ApplicationController
  
  def index
    @students = Course.find(params[:course_id]).students
  end
  
  def new
    @student = User.new
  end
  
  def create
    @student = User.new(params[:user].merge(:password => Devise.friendly_token))
    respond_to do |format|
      if @student.save
        Course.find(params[:course_id]).students << @student
        format.html { redirect_to(course_students_path(Course.find(params[:course_id])), :notice => 'Student was successfully added.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
