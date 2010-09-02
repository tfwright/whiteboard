class StudentsController < ApplicationController
  
  def index
    @students = Course.find(params[:course_id]).students
  end
  
end
