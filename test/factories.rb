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

Factory.define :upload do |upload|
  upload.name "Test Upload"
  upload.description "This is an test of the upload system.  This is only a test."
  upload.attached { fixture_file_upload('/files/syllabus.pdf', 'application/pdf') }
end