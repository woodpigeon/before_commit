module BeforeCommit
  module Runner
    def self.run
      pre_run_failures = Check.failures
      if pre_run_failures.empty?
        output FileManager.copy_dir_to_current source_dir
        config.commands.each do |cmd|
          output command.run cmd
        end
        output 'Process completed'
      else
        output 'Errors found:'
        pre_run_failures.each{|f| output "\t#{f}"}
        output 'Unable to run process'
        false
      end  
    end
    
    def self.source_dir
      @source_dir ||= File.join gem_root, 'source'
    end
    
    def self.gem_root
      @gem_root ||= File.expand_path '../..', File.dirname(__FILE__)
    end
    
    def self.output(text)
      puts text
    end
    
    def self.command
      @command ||= Command.new
    end
    
    def self.config
      @config = Config.new
    end

  end
end
