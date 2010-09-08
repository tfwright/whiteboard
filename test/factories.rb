Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.password  'test'
  user.email { Factory.next(:email) }
end

Factory.define :student, :parent => :user, :class => "Student" do |student|
  student.type "Student"
end

Factory.define :admin, :parent => :user, :class => "Admin" do |admin|
  admin.type "Admin"
end

Factory.define :professor, :parent => :user, :class => "Professor" do |professor|
  professor.type "Professor"
end

Factory.define :professor_with_course, :parent => :professor do |professor|
  professor.after_create { |professor| Factory(:course, :professor => professor) }
end

Factory.define :course do |course|
  course.title "Test course"
  course.code "testcode"
  course.begins_on Date.today
  course.ends_on 3.months.from_now
  course.association :professor
end

Factory.define :document do |document|
  document.name "Test Upload"
  document.description "This is an test of the document system.  This is only a test."
  document.attached { fixture_file_upload('/files/syllabus.pdf', 'application/pdf') }
end

Factory.define :assignment do |assignment|
  assignment.association :course
  assignment.name "Test assignment"
  assignment.due_at { 4.days.from_now }
  assignment.description "This is a test assignment."
end

Factory.define :submission do |submission|
  submission.association :student
  submission.association :assignment
  submission.upload { fixture_file_upload('/files/syllabus.pdf', 'application/pdf') }
end

Factory.define :announcement do |announcement|
  announcement.association :course
  announcement.subject "Test announcement"
  announcement.body "This is a test announcement."
end