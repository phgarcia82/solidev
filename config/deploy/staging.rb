set :stage, :staging

set :rvm_type, :user
set :deploy_to, 'C:\Production'
set :rails_env, "production"
server 'heroku.com', user: 'pierre.h.garcia@gmail.com', roles: %w{web app db}

config.action_mailer.default_url_options = { :host => 'myapp.herokuapp.com' }
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = false
config.action_mailer.default :charset => "utf-8"
config.action_mailer.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "myapp.herokuapp.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"]
}