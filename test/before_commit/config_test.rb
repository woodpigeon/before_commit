require 'test_helper'

module BeforeCommit
  class ConfigTest < Minitest::Test
    
    def setup
      Config.file_location = config_file_path
    end
    
    def test_commands
      assert_equal config_from_file['commands'], config.commands
    end
    
    def test_checks
      assert_equal config_from_file['checks'], config.checks
    end
    
    def config_from_file
      @config_from_file ||= YAML.load_file config_file_path
    end
    
    def config_file_path
      data_path('config.yml')
    end
    
    def config
      @config ||= Config.new
    end
    
  end
end
