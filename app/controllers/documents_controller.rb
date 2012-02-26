class DocumentsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => :show
  before_filter :ensure_enrolled

  # GET /Documents/new
  # GET /Documents/new.xml
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  def create
    @document = Document.new(params[:document].merge(params[:attachable]))
    respond_to do |format|
      if @document.save
        format.html { redirect_to(@document.attachable, :notice => 'Document was successfully created.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
    
end
