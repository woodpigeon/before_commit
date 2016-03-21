
module BeforeCommit
  class Check
    
    def self.failures
      all.collect(&:failure).compact
    end
    
    def self.all
      return [] unless config.checks.respond_to?(:values)
      config.checks.values.collect{|v| new v}
    end
    
    def self.config
      @config = Config.new
    end
    
    attr_reader :command, :expected, :failure_message
    def initialize(args)
      @command = args['command']
      @expected = args['expected']
      @failure_message = args['failure_message']
    end
    
    def run
      command_runner.run(command)
    end
    
    def result
      @result ||= run
    end
    
    def failure
      return command_runner.error unless success?
      failure_message unless failure_criteria =~ result
    end
    
    def failure_criteria
      Regexp.new expected
    end
    
    def command_runner
      @command_runner ||= Command.new
    end
    
    def success?
      result && command_runner.success?
    end
    
    
  end
end
