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
  end
end
