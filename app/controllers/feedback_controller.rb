class FeedbackController < ApplicationController
  
  layout false
  
  def deliver
    Notifier.feedback(params[:feedback]).deliver
    render :nothing => true
  end
  
end
