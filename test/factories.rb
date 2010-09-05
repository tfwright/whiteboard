Factory.define :user do |user|
  user.password  'test'
  user.email 'user@example.com'
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

Factory.define :course do |course|
  course.title "Test course"
  course.code "testcode"
  course.begins_on Date.today
  course.ends_on 3.months.from_now
end
 
 