module BeforeCommit
  module Runner
    def self.run
      pre_run_failures = Check.failures
      if pre_run_failures.empty?
        output FileManager.copy_dir_to_current source_dir
        output 'Be patient, on first run the next bit can take a few minutes'
        config.commands.each do |cmd|
          output command.run cmd
        end
        output 'Process completed'
      else
        output "#{pre_run_failures.length} errors found -"
        pre_run_failures.each_with_index{|f,i| output "  Error #{i+1}:\n\t#{f}\n"}
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
