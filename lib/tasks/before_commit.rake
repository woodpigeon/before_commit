namespace :before_commit do
  
  desc 'Run before commit tasks'
  task :run do
    BeforeCommit::Runner.run
    puts 'Completed running before_commit'
  end
  
end
