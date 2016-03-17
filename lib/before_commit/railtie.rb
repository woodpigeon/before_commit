module BeforeCommit
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../tasks/before_commit.rake', File.dirname(__FILE__))
    end
  end
end
