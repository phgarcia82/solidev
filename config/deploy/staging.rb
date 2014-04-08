set :stage, :staging

set :rvm_type, :user
set :deploy_to, '/home/solidareit/solidare-it/staging'
set :rails_env, "staging"
server 'jorisvh.net', user: 'solidareit', roles: %w{web app db}