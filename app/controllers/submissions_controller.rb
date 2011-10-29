class SubmissionsController < ApplicationController
  require 'zip/zipfilesystem'
  
  before_filter :set_current_course
  before_filter :ensure_enrolled
  before_filter :ensure_professor_or_admin, :only => :index
  before_filter :ensure_assignment_not_overdue, :only => [:new, :update, :create]
  before_filter :check_submittable, :only => :new
  

  def index
    @submissions = Assignment.find(params[:assignment_id]).submissions
    respond_to do |format|
      format.html
      format.zip do
        filename = "assignment_#{params[:assignment_id]}_submissions_#{Time.now.to_i}.zip"
        t = Tempfile.new(filename)
         Zip::ZipOutputStream.open(t.path) do |zip|
           @submissions.each do |submission|
             zip.put_next_entry(submission.upload_file_name)
             zip.print(open(URI.escape(submission.upload.url)).read)
           end
         end
         send_file t.path, :filename => "assignment_#{params[:assignment_id]}_submissions.zip"
         t.close
      end
    end
  end
  
  def new
    @submission = Submission.new
  end
  
  def create
    @submission = Submission.new(params[:submission])
    @submission.student_id = current_user.id unless current_user.is_a?(Professor)
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
  
    def ensure_assignment_not_overdue
      unless Assignment.find(params[:assignment_id]).due_at > Time.now || current_user.is_a?(Professor) && current_user.teaching?(@current_course)
        redirect_to course_path(@current_course), :warning => "You cannot submit or update overdue assignments."
      end
    end
  
    def check_submittable
      assignment = Assignment.find(params[:assignment_id])
      redirect_to course_assignment_path(@current_course, params[:assignment_id]), :warning => "This assignment does not require a submission" if !assignment.accepting_submissions? and return
      if current_user == @current_course.professor && @current_course.students.all?{|s| assignment.submitted?(s) }
        redirect_to course_assignment_submissions_path(@current_course, params[:assignment_id]), :notice => "All students have submitted this assignment" and return
      end
      if submission = Submission.first(:conditions => {:student_id => current_user.id, :assignment_id => params[:assignment_id]})
        redirect_to edit_course_assignment_submission_path(@current_course, params[:assignment_id], submission), :notice => "Please update your submission below"
      end
    end
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
  
    def ensure_owner
      render :nothing => true, :status => 401 unless @submission.student.id == current_user.id
    end
  
end