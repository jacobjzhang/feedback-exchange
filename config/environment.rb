# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :user_name => 'apikey',
  :password => ENV['SENDGRID_API_KEY'],
  :domain => 'feedback.exchange',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}