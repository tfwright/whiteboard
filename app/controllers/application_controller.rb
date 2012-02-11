class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :unless => Proc.new { high_voltage_controller? }
  before_filter :set_timezone, :unless => Proc.new { devise_controller? || high_voltage_controller? }
  before_filter :set_real_last_sign_in
  
  private
  
    def set_timezone
      Time.zone = current_user.time_zone
    end
  
    def ensure_professor_or_admin
      unless %w(Professor Admin).include?(current_user.type)
        render :json => {:error => "You do not have the right to do this to me!"}.to_json, :status => 403 and return if request.format.json?
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
    
    def high_voltage_controller?
      params["controller"] == "high_voltage/pages"
    end
    
    # This forces the timestamp to update even if the user is already logged in via a stored cookie
    def set_real_last_sign_in 
      if user_signed_in? && !session[:logged_sign_in]
        sign_in(current_user, :force => true)
        session[:logged_sign_in] = true
      end
    end
    
end
