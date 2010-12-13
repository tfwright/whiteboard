class AssignmentsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => :show
  before_filter :ensure_enrolled
    
  def index
    @assignments = @current_course.assignments
    respond_to do |format|
      format.html
      format.js  { render :json => @assignments.map{ |a| a.attributes.merge(:update_url => course_assignment_path(@current_course, a, :format => :js)) } }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    @assignment = Assignment.new(params[:assignment].merge(:course_id => params[:course_id]))

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to(course_assignment_path(:course_id => params[:course_id], :id => @assignment.id), :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      redirect_to(course_path(params[:course_id]), :notice => 'Assignment was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(assignments_url) }
      format.xml  { head :ok }
    end
  end
  
  def adjust_weighting
    @assignments = @current_course.assignments
    begin
      Assignment.transaction do
        params[:weighting].each do |id, weight|
          Assignment.find(id).update_attribute(:weight, weight)
        end
        raise "Invalid weighting" unless @current_course.assignments.sum(:weight) == 100
      end
      render :nothing => true, :status => 200
    rescue Exception => e
      render :text => e.message, :status => 406
    end
  end
  
  private
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
    
end
