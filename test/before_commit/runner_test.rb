require 'test_helper'

module BeforeCommit
  class RunnerTest < Minitest::Test   
    
    def test_run_triggers_processes
      Runner.stub(:output, true) do
        FileManager.stub(:copy_dir_to_current, true) do
          Check.stub(:failures, []) do
            assert Runner.run
          end
        end
      end
    end
    
    def test_run_with_check_failures
      Runner.stub(:output, true) do
        assert_equal false, Runner.run
      end
    end
    
    def test_source_dir
      path = File.expand_path '../../source', File.dirname(__FILE__)
      assert_equal path, Runner.source_dir
    end
    
    def test_success_count    
      assert_difference 'runner.success_count' do
        runner.run_command 'ls'
      end
    end
    
    def test_failures
      test_success_count
      assert_equal({}, runner.failures)
    end
    
    def test_failures_with_failure
      cmd = 'xxxxxxxxxxx'
      runner.run_command cmd
      assert_equal [cmd], runner.failures.keys
    end
    
    def runner 
      @runner ||= Runner.new
    end
  end
end
