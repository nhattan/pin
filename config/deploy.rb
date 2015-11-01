lock '3.4.0'

ENV["RAILS_ENV"] ||= 'staging'

set :application, 'pin'
set :repo_url, 'git@github.com:nhattan/pin.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/pin'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
set :linked_files, %w{.env}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/assets}

# Default value for default_env is {}
set :default_env, {
  rails_env: ENV["RAILS_ENV"],
}

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc "seed database"
  task :seed do
    on roles(:db) do |host|
      within "#{release_path}" do
        with rails_env: ENV["RAILS_ENV"] do
          execute :rake, "db:seed"
        end
      end
    end
  end

  after :migrate, :seed

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :publishing, :restart
end
