class Notifier < ActionMailer::Base
  default :from => "notifier@whiteboard.tfwright.info"
  
  def enrollment_notification(student, course)
    @student = student
    @course = course
    mail(:to => @student.email,
         :subject => "You have been enrolled in a Whiteboard course: " + @course.title )
  end
  
end
