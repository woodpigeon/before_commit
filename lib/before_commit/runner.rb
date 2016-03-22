module BeforeCommit
  class Runner
    class << self
      def run
        new.run_process
      end

      def source_dir
        @source_dir ||= File.join gem_root, 'source'
      end

      def gem_root
        @gem_root ||= File.expand_path '../..', File.dirname(__FILE__)
      end

      def output(text)
        puts text
      end
    end
    
    def initialize
      success_count
    end
             
    def run_process
      if pre_run_failures.empty?
        good_journey
      else
        bad_journey
      end  
    end
    
    def good_journey
      output FileManager.copy_dir_to_current self.class.source_dir
      output 'Be patient, on first run the next bit can take a few minutes'
      config.commands.each do |cmd|
        output run_command cmd
      end
      failures.empty? ? true : output(failure_report)
    end
    
    def bad_journey
      output "#{pre_run_failures.length} errors found -"
      pre_run_failures.each_with_index{|f,i| output "  Error #{i+1}:\n\t#{f}\n"}
      output 'Unable to run process'
      false   
    end
       
    def run_command(cmd)
      command.run cmd
      if command.success?
        @success_count += 1
      else
        failures[cmd] = command.result
      end
      command.result
    end
           
    def command
      @command ||= Command.new
    end
    
    def success_count
      @success_count ||= 0
    end
    
    def failures
      @failures ||= {}
    end
    
    def failure_report
      text = ["\n"]
      text << "#{success_count} commands ran successfully"
      text << "There were #{failures.length} failures"
      failures.each do |cmd, failure|
        text << "  Command `#{cmd}` failed"
        text << "\t#{failure}\n"
      end
      text.join("\n")
    end
    
    def config
      @config ||= Config.new
    end
    
    def pre_run_failures
      @pre_run_failures ||= Check.failures
    end
    
    def output(text)
      self.class.output text
    end
         
  end
end
