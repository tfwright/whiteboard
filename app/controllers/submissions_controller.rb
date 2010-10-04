class SubmissionsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_enrolled
  before_filter :ensure_professor_or_admin, :only => :index

  def index
    @submissions = Assignment.find(params[:assignment_id]).submissions
  end
  
  def new
    @submission = Submission.new
  end
  
  def create
    @submission = Submission.new(params[:submission])
    @submission.attributes = {:assignment_id => params[:assignment_id], :student_id => current_user.id}
    if @submission.save
      redirect_to(course_assignment_path(Course.find(params[:course_id]), @submission.assignment), :notice => 'Submission was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @submission = Submission.find(params[:id])
    ensure_owner
  end
  
  def update
    @submission = Submission.find(params[:id])
    ensure_owner
    if @submission.update_attributes(params[:submission])
      redirect_to(course_assignment_path(Course.find(params[:course_id]), @submission.assignment), :notice => 'Submission was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  private
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
  
    def ensure_owner
      render :nothing => true, :status => 401 unless @submission.student.id == current_user.id
    end
  
end