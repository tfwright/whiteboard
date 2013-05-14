source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.1.3'

gem 'devise', '~> 2.0.4'
gem 'paperclip', '~> 2.4.4'
gem 'aws-s3', '~> 0.6.2', :require => 'aws/s3'
gem 'truncate_html', '~> 0.4.0'
gem 'grit', '~> 2.4.1'
gem 'high_voltage', '~> 1.1.1'
gem 'exception_notification', '~> 2.5.2'
gem 'rubyzip', '~> 0.9.6.1'
gem 'will_paginate', '~> 3.0.3'
gem 'addressable', '~> 2.2.7'

group :production, :staging do
 gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'heroku'
end

group :test do
  gem 'factory_girl_rails'
  gem 'ruby-debug19'
  gem 'rr'
end