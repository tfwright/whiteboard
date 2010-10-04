# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Whiteboard::Application.initialize!

ActiveRecord::Base.include_root_in_json = false

Whiteboard::Application.config.time_zone = "Central Time (US & Canada)"
