class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  private
  
    def ensure_professor_or_admin
      unless %w(Professor Admin).include?(current_user.type)
        flash[:warning] = "You do not have the right to do this to me!"
        redirect_to root_url
      end
    end
    
    def ensure_enrolled
      unless current_user.type == "Admin" || current_user.courses.include?(@current_course)
        redirect_to courses_path
      end
    end
    
    def ensure_admin
      unless current_user.is_a?(Admin)
        redirect_to root_url, :warning => "You do not have permission."
      end
    end
    
end
