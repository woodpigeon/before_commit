require 'yaml'
module BeforeCommit
  class Config
    
    class << self
      attr_writer :file_location
      
      def file_location
        @file_location ||= File.expand_path('../../config/config.yml', File.dirname(__FILE__))
      end
    end
    
    def commands
      data['commands']
    end
    
    def checks
      data['checks']
    end
    
    def data
      @data ||= YAML.load_file self.class.file_location
    end
    
  end
end
