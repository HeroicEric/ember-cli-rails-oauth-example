require 'rake'

task :run do
  pids = [
    spawn('cd backend && rails s'),
    spawn('cd frontend && ember server --proxy http://localhost:3000'),
  ]

  trap 'INT' do
    Process.kill 'INT', *pids
    exit 1
  end

  loop do
    sleep 1
  end
end

namespace :deploy do
  desc 'Deploy frontend to Firebase'
  task :frontend do
    puts 'Deploying frontend to Firebase...'
    system('cd frontend && ember build --environment production && firebase deploy')
  end

  desc 'Deploy backend to Heroku'
  task :backend do
    puts 'Deploying backend to Heroku...'
    system('git push heroku `git subtree split --prefix backend`:master')
  end

  task all: [:frontend, :backend]
end

desc 'Deploy frontend and backend'
task deploy: 'deploy:all'
