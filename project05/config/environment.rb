# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Articles::Application.initialize!

# Enable Haml in Rails
config.gem "haml"