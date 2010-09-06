class SubmissionsController < ApplicationController

  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  def create
    @submission = Submission.new(params[:submission].merge(:assignment_id => params[:assignment_id], :student_id => current_user.id))
    if @submission.save
      redirect_to(course_assignment_path(Course.find(params[:course_id]), @submission.assignment), :notice => 'Submission was successfully created.')
    else
      render :action => "new"
    end
  end
  
end