Factory.define :user do |user|
  user.password  'test'
  user.email 'user@example.com'
end

Factory.define :student, :parent => :user do |student|
  student.type "Student"
end

Factory.define :course do |course|
  course.name "Test course"
  course.begins_on Date.today
  course.ends_on 3.months.from_now
end
 
 