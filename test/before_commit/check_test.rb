require 'test_helper'

module BeforeCommit
  class CheckTest < Minitest::Test
    
    def setup
      Config.file_location = config_file_path
    end
    
    def test_run
      assert_equal good['expected'], check.run.strip
    end

    def test_failure
      assert_equal nil, check.failure
    end 
    
    def test_failure_with_bad
      @check = Check.new(bad)
      assert_equal bad['failure_message'], check.failure
    end
    
    def test_failure_with_error
      @check = Check.new(error)
      assert_match(/No such file/, check.failure)
    end
    
    def test_failures
      failures = Check.failures
      assert_equal 2, failures.length
      assert_match(/No such file/, failures.join)
      assert failures.include?(bad['failure_message']), "should include bad failure message"
    end
    
    def good
      @good ||= config.checks['good']
    end
    
    def bad
      @bad ||= config.checks['bad']
    end
    
    def error
      @error ||= config.checks['error']
    end
    
    def check
      @check ||= Check.new(good)
    end
    
    def config
      @config = Config.new
    end
  end
end
