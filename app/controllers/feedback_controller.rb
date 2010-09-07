class FeedbackController < ApplicationController
  
  layout false
  
  def deliver
    Notifier.feedback(params[:feedback])
    render :nothing => true
  end
  
end
