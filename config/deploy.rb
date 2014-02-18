# config valid only for Capistrano 3.1
lock '3.1.0'

# setup multistage
set :stages, %w(testing production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "rails_app"
set :repository,  "git@github.com:username/rails_app.git"

set :user, "ec2-user"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/ubuntu/web/depot_test'

# Default value for :scm is :git
set :scm, :git

desc "check production task"
task :check_production do
  if stage.to_s == "production"
    puts " \n Are you REALLY sure you want to deploy to production?"
    puts " \n Enter the password to continue\n "
    password = STDIN.gets[0..7] rescue nil
    if password != 'mypasswd'
      puts "\n !!! WRONG PASSWORD !!!"
      exit
    end
  end
end

role :web, "ec2-54-229-160-200.eu-west-1.compute.amazonaws.com/depot_test" # Your HTTP server, Apache/etc
role :app, "ec2-54-229-160-200.eu-west-1.compute.amazonaws.com/depot_test" # This may be the same as your `Web` server
role :db,  "ec2-54-229-160-200.eu-west-1.compute.amazonaws.com/depot_test", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc 'Restart application'
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     # Your restart mechanism here, for example:
  #     # execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

before "deploy", "check_production"








set :repo_url, 'git@example.com:me/my_repo.git'

