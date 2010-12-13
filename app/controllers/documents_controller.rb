class DocumentsController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => :show
  before_filter :ensure_enrolled
    
  # GET /Documents
  # GET /Documents.xml
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  # GET /Documents/1
  # GET /Documents/1.xml
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /Documents/new
  # GET /Documents/new.xml
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /Documents/1/edit
  def edit
    @document = Document.find(params[:id])
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

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      redirect_to(course_path(params[:course_id]), :notice => 'Document was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /Documents/1
  # DELETE /Documents/1.xml
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
    
end
