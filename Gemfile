source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'devise', '2.0.4'
gem 'paperclip', '2.4.4'
gem 'aws-s3', :require => 'aws/s3'
gem 'truncate_html', '0.4.0'
gem 'grit'
gem 'high_voltage'
gem 'exception_notification'
gem 'rubyzip'
gem 'fastercsv'
gem 'will_paginate'
gem 'addressable'

group :production, :staging do
 gem 'pg'
end

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :development do 
  gem 'heroku'
end

group :test do
  gem 'factory_girl'
  gem 'redgreen'
  gem 'single_test'
  gem 'ruby-debug'
  gem 'rr'
end