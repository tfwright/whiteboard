FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do |user|
    user.password  'test'
    user.email { generate(:email) }
  end

  factory :student, :parent => :user, :class => "Student" do |student|
    student.type "Student"
  end

  factory :admin, :parent => :user, :class => "Admin" do |admin|
    admin.type "Admin"
  end

  factory :professor, :parent => :user, :class => "Professor" do |professor|
    professor.type "Professor"
  end

  factory :professor_with_course, :parent => :professor do |professor|
    professor.after_create { |professor| create(:course, :professor => professor) }
  end

  factory :course do |course|
    course.title "Test course"
    course.begins_on Date.today
    course.ends_on 3.months.from_now
    course.association :professor
    course.time_zone "Pacific Time (US & Canada)"
  end

  factory :document do |document|
    document.name "Test Upload"
    document.description "This is an test of the document system.  This is only a test."
    document.association :attachable, :factory => :course
    document.attached { fixture_file_upload('/files/syllabus.pdf', 'application/pdf') }
  end

  factory :assignment do |assignment|
    assignment.association :course
    assignment.name "Test assignment"
    assignment.due_at { 4.days.from_now }
    assignment.description "This is a test assignment."
  end

  factory :submission do |submission|
    submission.association :student
    submission.association :assignment
    submission.upload { fixture_file_upload('/files/syllabus.pdf', 'application/pdf') }
  end

  factory :announcement do |announcement|
    announcement.association :course
    announcement.subject "Test announcement"
    announcement.body "This is a test announcement."
  end

  factory :link do |link|
    link.name "Test link"
    link.url "http://test.example.com"
    link.description "This is a test link"
    link.association :course
  end

  factory :grade do |grade|
    grade.association :assignment
    grade.association :student
    grade.score 75
  end

  factory :post do |post|
    post.association :course
    post.association :author, :factory => :student
    post.body "This is some body text"
  end
end