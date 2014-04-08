set :stage, :production

set :rvm_type, :user
set :deploy_to, '/home/solidareit/solidare-it/production'
set :rails_env, "production"
server 'jorisvh.net', user: 'solidareit', roles: %w{web app db}