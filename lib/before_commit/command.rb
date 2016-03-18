require 'open3'
module BeforeCommit
  class Command
    attr_reader :input, :success, :error, :result
    def run(cmd)
      reset
      @input = cmd
      stdout, stderr, status = Open3.capture3(cmd)
      @result = case status.exitstatus
      when 0
        @success = stdout
      when 1, 127
        @error = stderr
      end
    rescue Errno::ENOENT => e
      @result = @error = e.message
    end
    
    def success?
      !!success
    end
    
    def reset
      @input = @success = @error = @result = nil
    end
  end
end