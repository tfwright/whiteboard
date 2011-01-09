class Notifier < ActionMailer::Base
  default :from => "Whiteboard <notifier@#{DOMAIN}>"
  
  def enrollment_notification(student, course)
    @student = student
    @course = course
    mail(:to => @student.email,
         :subject => "You have been enrolled in a Whiteboard course: " + @course.title )
  end
  
  def new_account_notification(student)
    @student = student
    mail(:to => @student.email,
         :subject => "Your account has been created on Whiteboard")
  end
  
  def feedback(feedback)
    @feedback = feedback
    mail(:to => ENV['CONTACT'],
      :subject => "Whiteboard Feedback: " + feedback[:summary] + feedback[:feeling])
  end
  
  def announcement(announcement, student)
    @announcement = announcement
    mail(:to => student.email,
      :subject => "[#{announcement.course.title}] " + @announcement.subject)
  end
  
end
