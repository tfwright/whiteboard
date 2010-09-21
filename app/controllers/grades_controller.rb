class GradesController < ApplicationController
  
  before_filter :set_current_course
  before_filter :ensure_professor_or_admin, :except => [:index]
  before_filter :ensure_enrolled
  
  def index
    @students = @current_course.students
    unless current_user.is_a?(Professor) || current_user.is_a?(Admin)
      @students.find(current_user.id)
    end
  end

  def create
    @grade = Grade.new(params[:grade])
    respond_to do |format|
      format.js do
        if @grade.save
          render :json => @grade.attributes.merge(:update_url => course_grade_path(@current_course, @grade, :format => :js))
        else
          render :json => @grade.errors, :status => 406
        end
      end
    end
  end

  def update
    @grade = Grade.find(params[:id])
    respond_to do |format|
      format.js do
        if @grade.update_attributes(params[:grade])
          render :json => @grade
        else
          render :json => @grade.errors, :status => 406
        end
      end
    end
  end

  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy
    redirect_to(course_grades_url(@current_course))
  end
  
  private 
  
    def set_current_course
      @current_course ||= Course.find(params[:course_id])
    end
    
end
